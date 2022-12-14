//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        // address 	0x8A753747A1Fa494EC906cE90E9f37563A8AF630e ETH / USD
        (, int256 price, , , ) = priceFeed.latestRoundData();

        return uint256(price * 1e10);
    }

    function getConversionRate(
        uint256 cryptoAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 cryptoPrice = getPrice(priceFeed);
        uint256 cryptoAmountInUsd = (cryptoPrice * cryptoAmount) / 1e18;
        return cryptoAmountInUsd;
    }
}
