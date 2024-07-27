// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our solidity version
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address [] funders;

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    
    // state variable to hold address of the deployer
    address public owner;
    constructor(){
        //deployer of the contract
        owner = msg.sender;
    }

    function fund() public payable {
        // Validation to set minim required qwei
        require(msg.value.getConversionrate() > minimumUsd, "did'nt send enough ETH"); // 1e18 = 1ETH = 1000000000000000000

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }


    function withdraw() public{
        require(msg.sender == owner, "Must be owner");
        
        for(uint256 fundIndex = 0; fundIndex < funders.length; fundIndex++ ){
            address funder = funders[fundIndex];
            addressToAmountFunded[funder] = 0;
        }

        // Reset the funders array to start at lenght zero
        funders = new address[](0);

        //three ways to send funds
        // 1. Transfer
        // 2. Send 
        // 3. Call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");
    }

}