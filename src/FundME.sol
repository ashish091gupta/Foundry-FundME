// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";


error FundMe_NotOwner();


contract FundMe{

    using  PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] private s_funders;

    mapping ( address funder => uint256 amountFunded) private s_addressToAmountFunded;

    address private immutable i_owner;
    AggregatorV3Interface private s_priceFeed;

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {

        //allow to user to send $
        //have a minimum $ send $ 5
         //if not send $5  revert the transaction 
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD,"Not enough fund.");
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] +=  msg.value;
    }

    function withdraw() public onlyOwner {
       
        for(/*first loop*/ uint256 funderIndex =0 ; funderIndex< s_funders.length; funderIndex++ ){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
            
        }

        s_funders = new address[](0);

        //transfer method 
        //msg.sender = address
        //payable(msg.sender)= parable address
        //payable (msg.sender).transfer(address(this).balance);

        //send method
        //return true or false
        //bool sendSucessful = payable(msg.sender).send(address(this).balance);
        //require(sendSucessful,"send fail"); //by add require we can  revert 

        //call method
        (bool callSucessful,) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSucessful,"call fails");


    }

    function cheaperWithdraw() public onlyOwner {
        uint256 funderLength = s_funders.length;
       
        for(/*first loop*/ uint256 funderIndex =0 ; funderIndex< funderLength; funderIndex++ ){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
            
        }

        s_funders = new address[](0); //set the array to empty array to reset the funders list

        //transfer method 
        //msg.sender = address
        //payable(msg.sender)= parable address
        //payable (msg.sender).transfer(address(this).balance);

        //send method
        //return true or false
        //bool sendSucessful = payable(msg.sender).send(address(this).balance);
        //require(sendSucessful,"send fail"); //by add require we can  revert 

        //call method
        (bool callSucessful,) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSucessful,"call fails");


    }

    modifier onlyOwner( ) {
        //require(msg.sender ==i_owner, "Must be owner");
        if (msg.sender != i_owner) {
            revert FundMe_NotOwner();
        }
         _;
    }

    receive() external payable{
        fund();
    }

    fallback() external payable{
        fund();
    }

    function getVersion() public view returns (uint256) {
    return s_priceFeed.version();
    }

    function getAddressToAmountFunded(address fundedAddress ) external view returns (uint256) {
        return s_addressToAmountFunded[fundedAddress];
        
    }

    function getFunder(uint256 index) external view returns (address) {
        return s_funders[index];
    }

    function getOwner() external view returns (address) {
        return i_owner;
    }




}