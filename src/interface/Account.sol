// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.26;

interface IAccount {
    /// @notice Thrown when the requested accountId is greater than MAX_INT/2;
    error InvalidAccountId(uint128 accountId);

    error NotTheOwner(uint128 accountId);

    /**
     * @notice Emitted when an account token with id `accountId` is minted to `sender`.
     * @param accountId The id of the account.
     * @param owner The address that owns the created account.
     */
    event AccountCreated(uint128 indexed accountId, address indexed owner);



    /**
     * @notice Mints an account token with an available id to `ERC2771Context._msgSender()`.
     *
     * Emits a {AccountCreated} event.
     */
    function createAccount() external returns (uint128);


    function transferAccount(address to,uint128 accountId) external;

    function getAccountOwner(uint128 accountId) external returns (address);


}
