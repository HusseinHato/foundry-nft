// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DogNFT} from "src/DogNFT.sol";

contract DeployDogNFT is Script {
    function run() external returns (DogNFT) {
        vm.startBroadcast();
        DogNFT dogNFT = new DogNFT();
        vm.stopBroadcast();
        return dogNFT;
    }
}