// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

interface IAccountToken{
    function safeMint(address to)  external returns(uint128 accountId);
    function transferTo(address to, uint128 accountId) external;

    function getAccountOwner(uint128 accountId) view external returns(address owner);
}