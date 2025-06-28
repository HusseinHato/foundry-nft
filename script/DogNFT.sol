// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract DogNFT is ERC721 {
    uint256 public s_tokenCounter;

    constructor() ERC721("DogNFT", "DOG") {
        s_tokenCounter = 0;
    }
    
    function mintNFT() external {}

    function tokenURI(uint256 tokenId) public override view returns (string memory) {

    }
}