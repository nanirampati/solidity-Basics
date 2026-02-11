// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
// this is a library and it is similar to contract
import{AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConvertor{
// libraries didn't have any state variables and functions internal
function getprice() internal  view returns (uint256){

    

    AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    (,int256 price,,,)=priceFeed.latestRoundData();
    // price of ETH in terms of USD
    return uint256(price * 1e10);
    }
    function getconversionRate(uint256 ethAmount) internal  view returns(uint256){
        // 1Eth?
        // 2000_000000000000000000
        uint256 ethprice=getprice();
        //2000_000000000000000000 * 1_0000000000000000
        // $20000=1ETH
        uint256 ethAmountUsd=(ethprice*ethAmount)/1e18;
    }
    function getVersion() internal  view returns (uint256) {
        
            return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
        
    }
}