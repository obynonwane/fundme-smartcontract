

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our solidity version
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

uint256 public minimumUsd = 5e18;
address [] funders;
mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    //make a function payable to allow it to accept native blockchain currency
    function fund() public payable {
        // Validation to set minim required qwei
        require(getConversionrate(msg.value) > minimumUsd, "did'nt send enough ETH"); // 1e18 = 1ETH = 1000000000000000000

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        ( ,int price,,,) = priceFeed.latestRoundData();
       return uint256(price * 1e10);
    }

    
    function getConversionrate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e10;
        return ethAmountInUsd;

    }

}