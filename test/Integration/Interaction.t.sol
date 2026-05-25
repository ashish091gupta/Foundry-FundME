// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test,console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundME.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe ,WithdrawFundMe} from "../../script/Interaction.s.sol";

contract InteractoinTest is Test {
   FundMe fundMe;
    address   USER = makeAddr("user"); //makeAddr is a helper function from forge-std to create a random address with a name
    uint256 constant SEND_VALUE = 1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    //uint256 constant GAS_PRICE = 1; //


    function setUp() public {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE); //give user STARTING_BALANCE ether
    }

    function testUserCanFundInteraction() public {

        FundFundMe fundFundMeScript = new FundFundMe();
        
        vm.startPrank(USER);
        vm.deal(USER, STARTING_BALANCE);
        fundMe.fund{value: SEND_VALUE}();
        vm.stopPrank();

        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
        

        //FundFundMe fundFundMeScript = new FundFundMe();
        //fundFundMeScript.fundFundMe(address(fundMe));

        //WithdrawFundMe withdrawFundMeScript = new WithdrawFundMe();
        //withdrawFundMeScript.withdrawFundMe(address(fundMe));
        
        address owner = fundMe.getOwner(); //get owner of the contract
        vm.prank(owner); //next tx will be sent by owner
        fundMe.withdraw();
        assertEq(address(fundMe).balance ,0);
        
    }

}