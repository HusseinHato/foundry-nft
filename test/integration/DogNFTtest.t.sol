// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DogNFT} from "src/DogNFT.sol";
import {DeployDogNFT} from "script/DeployDogNFT.s.sol";

contract DogNFTtest is Test {
    DeployDogNFT public deployer;
    DogNFT public dogNFT;

    address public USER = makeAddr("user");
    string constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployDogNFT();
        dogNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "DogNFT";
        string memory actualName = dogNFT.name();
        assert(keccak256(abi.encodePacked(actualName)) == keccak256(abi.encodePacked(expectedName)));
    }

    function testCanMintNFTAndHaveBalance() public {
        vm.prank(USER);
        dogNFT.mintNFT(PUG);

        assert(dogNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(dogNFT.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));
    }
}