// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {

    error MoodNFT__CantFlipMoodIfNorOwnerOrApproved();

    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;
    uint256 private s_tokenCounter;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping (uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory happySvg, string memory sadSvg) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvg;
        s_sadSvgImageUri = sadSvg;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNFT__CantFlipMoodIfNorOwnerOrApproved();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happySvgImageUri;
        } else {
            imageUri = s_sadSvgImageUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '"{"name": "', name(), '","description": "An NFT that reflects your mood!","attributes": [{"trait_type": "Mood", "value": 100}], "image": "',
                            imageUri, '"}'
                        )
                    )
                )
            )
        );
    }
}