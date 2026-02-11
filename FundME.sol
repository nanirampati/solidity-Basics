// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Get funds from users
// withdraw
// set a minimum funding value in USD
import {PriceConvertor} from "./PriceConvertor.sol";
error notowner();

//import{AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";



contract Fundme {
    using PriceConvertor for uint256;
    address[] public funders;
    mapping(address => uint256 amountfunded) public addresstoAmountFunded;
    uint256 public constant minimumUSD=5e18;
    // constant is used to reduce gas cost 
    // 2315 gas - non constant
    // 2134 gas- constant
    //uint256 public myvalue = 1;
    address public immutable i_owner;
    // immutable also used to reduce gas and is used inside constructor and can be assigned only once
    constructor(){
        i_owner= msg.sender;
    }

    function fund() public payable {
       // myvalue += 2;
       // msg.value.getconversionRate()
        require(msg.value.getconversionRate()>= minimumUSD, "Didn't send enough ETH");
        funders.push(msg.sender);
        addresstoAmountFunded[msg.sender]= addresstoAmountFunded[msg.sender]+msg.value;
    }
    function withdraw()  public onlyowner{
        require(msg.sender== i_owner,"must be owner");
        // for loop
        // [1,2,3,4] elements
        // 0,1,2,3 indexes
        for(uint256 funderindex=0; funderindex<funders.length; funderindex=funderindex+1){
            address funder=funders[funderindex];
            addresstoAmountFunded[funder] = 0;
        }
        funders= new address[](0); // resetting the array
        // actually withdraw the funds
        //tranfer
        // msg.sender=address
        //payable(msg.sender)= payable address
        //payable (msg.sender).transfer(address(this).balance); // trasfer reverts if the transaction got failed
        //send
        //call
        // (bool callsucess,)=payable (msg.sender).call{value:address(this)}("");
        // require(callsucess,"call failed");
        (bool success, ) = payable(i_owner).call{value: address(this).balance}("");
         require(success, "Call failed");
    }
    modifier onlyowner(){
       // require(msg.sender== i_owner,"sender is not owner");
        _; // indicates to do the rest of the function
        if(msg.sender != i_owner){revert notowner();} // saves gas instead of a big string in require
    }
    // what happens if someone sends this contract ETH without calling the fund function
    // recieve()
    // fallback()
    receive() external payable { 
        fund();
    }
    fallback() external payable { 
        fund();
    }

    // these fund and recieve functions revert to fund function when someone sends ETH without the call data or calling the fund function
}
//     function getprice() public view returns (uint256){

    

//     AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
//     (,int256 price,,,)=priceFeed.latestRoundData();
//     // price of ETH in terms of USD
//     return uint256(price * 1e10);
//     }
//     function getconversioRate(uint256 ethAmount) public view returns(uint256){
//         // 1Eth?
//         // 2000_000000000000000000
//         uint256 ethprice=getprice();
//         //2000_000000000000000000 * 1_0000000000000000
//         // $20000=1ETH
//         uint256 ethAmountUsd=(ethprice*ethAmount)/1e18;
//     }
//     function getVersion() public view returns (uint256) {
        
//             return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
        
//     }