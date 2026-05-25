// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundME.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address   USER = makeAddr("user"); //makeAddr is a helper function from forge-std to create a random address with a name
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    //uint256 constant GAS_PRICE = 1; //


    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE); //give user STARTING_BALANCE ether
    }

    function testMinimumDollar() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        
    }

    function testOwner() public view {
        assertEq(fundMe.getOwner(),msg.sender);
    }

    function testPriceFeedVersion() public view{
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert(); //hey , the next line should be revert
        //assert(this tx fials if we dont send any eth)
        fundMe.fund();

    }

    function  testFundUpdateFundedDataStructure() public {
        
        vm.prank(USER); //next tx will be sent by user
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(address(USER));
        assertEq(amountFunded, SEND_VALUE);
    }

    function  testAddFunderUserArray() public{
        vm.prank(USER);
        fundMe.fund{value:SEND_VALUE}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    
    }

    modifier funded {
        vm.prank(USER);
        fundMe.fund{value:SEND_VALUE}();
        _;
        
    }

    function testOnlyOwnerCanWithdraw() public funded{
        vm.prank(USER); //next tx will be sent by user
        vm.expectRevert();
        fundMe.withdraw();
    }

    function testWithDrawOnlySingleOwner() public funded {
        //Arrange
        uint256 startBalanceOfFunder = fundMe.getOwner().balance;
        uint256 startBalanceOfContract = address(fundMe).balance;

        //Act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        //Assert
        uint256 endBalanceOfFunder = fundMe.getOwner().balance;
        uint256 endBalanceOfContract = address(fundMe).balance;
        assertEq(endBalanceOfContract, 0);
        assertEq(startBalanceOfContract + startBalanceOfFunder  , endBalanceOfFunder);

    }

    function testWithDrawFromMultipleFunders() public  funded{
        //Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for(uint160 i = startingFunderIndex; i < numberOfFunders; i++)
        {
            //we need to convert i to address
            hoax(address(i), SEND_VALUE); //hoax is a helper function from forge-std to set the next tx sender and give them some eth
            fundMe.fund{value:SEND_VALUE}();
        }

        uint256 startBalanceOfOwner = fundMe.getOwner().balance;
        uint256 startBalanceOfContract = address(fundMe).balance;

        //Act
        //uint256 gasStart = gasleft(); //1000 //gasleft is a built in function gives hou much gas left.
        //vm.txGasPrice(GAS_PRICE); //set the gas price for the next tx
        vm.startPrank(fundMe.getOwner()); //we can use startPrank and stopPrank to send multiple tx from the same sender
        fundMe.withdraw(); //200
        vm.stopPrank();
        //uint256 gasEnd = gasleft(); //800

        //uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice; //tx.gasprice is the gas price we set with vm.txGasPrice is bulit in variable that we can use to get the gas price of the current tx
        //console.log("Gas Used: ", gasUsed);

        //Assert
        assertEq(address(fundMe).balance, 0);
        assertEq(startBalanceOfContract + startBalanceOfOwner,fundMe.getOwner().balance);
    }

    function testCheaperWithDrawFromMultipleFunders() public  funded{
        //Arrange
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for(uint160 i = startingFunderIndex; i < numberOfFunders; i++)
        {
            //we need to convert i to address
            hoax(address(i), SEND_VALUE); //hoax is a helper function from forge-std to set the next tx sender and give them some eth
            fundMe.fund{value:SEND_VALUE}();
        }

        uint256 startBalanceOfOwner = fundMe.getOwner().balance;
        uint256 startBalanceOfContract = address(fundMe).balance;

        //Act
        //uint256 gasStart = gasleft(); //1000 //gasleft is a built in function gives hou much gas left.
        //vm.txGasPrice(GAS_PRICE); //set the gas price for the next tx
        vm.startPrank(fundMe.getOwner()); //we can use startPrank and stopPrank to send multiple tx from the same sender
        fundMe.cheaperWithdraw(); //200
        vm.stopPrank();
        //uint256 gasEnd = gasleft(); //800

        //uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice; //tx.gasprice is the gas price we set with vm.txGasPrice is bulit in variable that we can use to get the gas price of the current tx
        //console.log("Gas Used: ", gasUsed);

        //Assert
        assertEq(address(fundMe).balance, 0);
        assertEq(startBalanceOfContract + startBalanceOfOwner,fundMe.getOwner().balance);
    }
}