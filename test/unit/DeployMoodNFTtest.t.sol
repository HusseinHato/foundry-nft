// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";

contract DeployMoodNFTtest is Test {
    DeployMoodNFT deployer;

    function setUp() public {
        deployer = new DeployMoodNFT();
    }

    function testConvertSVGToURI() public view {
        string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIyMDAiIHk9IjI1MCIgZmlsbD0iYmxhY2siPkhpISBZb3UgZGVjb2RlZCB0aGlzISA8L3RleHQ+PC9zdmc+";
        string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="200" y="250" fill="black">Hi! You decoded this! </text></svg>';

        string memory actualUri = deployer.svgToImageUri(svg);

        // console2.log(expectedUri);
        // console2.log(actualUri);
        assert(keccak256(abi.encodePacked(expectedUri)) == keccak256(abi.encodePacked(actualUri)));
    }
}
