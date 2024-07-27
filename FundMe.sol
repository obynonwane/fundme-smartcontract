

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our solidity version
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

using PriceConverter for uint256;
uint256 public minimumUsd = 5e18;
address [] funders;
mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    //make a function payable to allow it to accept native blockchain currency
    function fund() public payable {
        // Validation to set minim required qwei
        require(msg.value.getConversionrate() > minimumUsd, "did'nt send enough ETH"); // 1e18 = 1ETH = 1000000000000000000

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }


}