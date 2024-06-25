// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {ContextUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import {IAccountToken} from "./interface/AccountToken.sol";
import {Math}from "@openzeppelin/contracts/utils/math/Math.sol";
import {SafeCast}from "@openzeppelin/contracts/utils/math/SafeCast.sol";

contract AccountToken is Initializable,ContextUpgradeable, OwnableUpgradeable,ERC721Upgradeable , UUPSUpgradeable, IAccountToken {

    using Math for uint128;

    uint128 internal offset;
    uint128 internal constant MAX_INT = 2**128 - 1; 


    function initialize() external initializer {
        offset = 0;
        __ERC721_init("Franthetix Account" , "FAT");
        __Ownable_init(_msgSender());
        __UUPSUpgradeable_init();
    }

    function safeMint(address to) external  onlyProxy returns (uint128 accountId) {
        /// @dev not using safe math because it is very unrealistic that we will ever have 2**64 users for this to fail
        accountId = (MAX_INT/2) + offset;
        offset += 1;
        _safeMint(to,accountId);
    }

    function transferTo(address to, uint128 acccountId) external override{
        transferFrom(_msgSender(),to,acccountId);
    }

    function getAccountOwner(uint128 accountId) external view returns(address owner){
        owner = ownerOf(accountId);
    }
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner{} 
}
