// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {ContextUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import {IAccount} from "./interface/Account.sol";
import {IAccountToken} from "./interface/AccountToken.sol";

contract AccountModule is
    Initializable,
    ContextUpgradeable,
    OwnableUpgradeable,
    UUPSUpgradeable,
    IAccount
{
    address tokenAddress;
    uint128 internal constant MAX_INT = 2 ** 128 - 1;
    IAccountToken token = IAccountToken(tokenAddress);


    function initialize(address accountTokenAddress) external initializer {
        __Ownable_init(_msgSender());
        __UUPSUpgradeable_init();
        tokenAddress = accountTokenAddress;
    }

    function createAccount() external returns (uint128 accountId) {
        accountId = IAccountToken(tokenAddress).safeMint(_msgSender());
        emit AccountCreated(accountId, _msgSender());
    }

    function transferAccount(address to, uint128 accountId) external {
        _checkAccountId(accountId);
        _checkAccountOwner(accountId);
        token.transferTo(to, accountId);
    }

    function _checkAccountId(uint128 accountId) internal pure {
        if (accountId > MAX_INT / 2) {
            revert InvalidAccountId(accountId);
        }
    }

    function getAccountOwner(uint128 accountId) external view returns(address){
        _checkAccountId(accountId);
        return token.getAccountOwner(accountId);
    }

    function _checkAccountOwner(uint128 accountid) internal view {
        if (_msgSender() !=token.getAccountOwner(accountid)) {
            revert NotTheOwner(accountid);
        }
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
