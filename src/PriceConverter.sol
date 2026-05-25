// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {

    function getPrice(AggregatorV3Interface priceFeed) internal view returns(uint256) {
        //
        //
        (,int256 price,,,) = priceFeed.latestRoundData();
        //price  of eth in terms of USD
        require(price > 0,"price is less than zero");
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount ,AggregatorV3Interface priceFeed)internal view returns(uint256){
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmoountInUsd = (ethPrice * ethAmount)/1e18;
        return ethAmoountInUsd;


    }

    function getVersion() internal view returns (uint256){
        return AggregatorV3Interface( 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43).version();
    }

}