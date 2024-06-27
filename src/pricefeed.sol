//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(address _address) public view returns (uint256) {
        AggregatorV3Interface pricefeed = AggregatorV3Interface(_address);

        //addresses
        // BTC/USD : 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        // ETH/USD : 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // for sepolia testnet hein ye

        (, int256 answer, , , ) = pricefeed.latestRoundData();
        return uint256(answer * 10000000000);
    }
}
