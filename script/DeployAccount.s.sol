// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script} from "forge-std/Script.sol";
import {Upgrades} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {AccountModule} from "../src/Account.sol";


contract DeployAccount is Script {
    function run() external returns (address proxy){
        address accountToken = DevOpsTools.get_most_recent_deployment("AccountToken",block.chainid);
        proxy = Upgrades.deployUUPSProxy(
            "Account.sol",
            abi.encodeCall(
                AccountModule.initialize,
                (accountToken)
            )
        );
    }
}