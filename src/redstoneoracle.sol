//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import "@redstone-finance/evm-connector/contracts/data-services/MainDemoConsumerBase.sol";

contract YourContractName is MainDemoConsumerBase{
    uint256 ethPrice = getOracleNumericValueFromTxMsg(bytes32("ETH"));
}