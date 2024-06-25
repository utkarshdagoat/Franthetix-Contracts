// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {AccountToken} from "../src/AccountToken.sol";

contract DeployAccountToken is Script {
    function run() external returns(address) {
        vm.startBroadcast();
        address proxy = Upgrades.deployUUPSProxy(
            "AccountToken.sol",
            abi.encodeCall(
                AccountToken.initialize,
                ()
            )
        );
        vm.stopBroadcast();
        return proxy;
    }
}
