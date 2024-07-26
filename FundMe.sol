

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // stating our solidity version

contract FundMe {

    //make a function payable to allow it to accept native blockchain currency
    function fund() public payable {
        // Allow users to sent $
        // Have a minimum $ sent 

        // Validation to set minim required qwei
        require(msg.value > 1e18, "did'nt send enough ETH"); // 1e18 = 1ETH = 1000000000000000000
    }

    function withdraw() public{}

}