// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DogNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping (uint256 => string) private s_tokenIdtoURI;

    constructor() ERC721("DogNFT", "DOG") {
        s_tokenCounter = 0;
    }
    
    function mintNFT(string memory tokenURI) public returns (uint256) {
        s_tokenIdtoURI[s_tokenCounter] = tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;

        return s_tokenCounter - 1; // Return the tokenId of the newly minted NFT
    }

    function tokenURI(uint256 tokenId) public override view returns (string memory) {
        return s_tokenIdtoURI[tokenId];
    }
}