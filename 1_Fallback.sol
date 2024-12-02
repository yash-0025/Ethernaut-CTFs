// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



//////// @title Solution Fallback
/// @author  Yash Patel

// => We have to get the ownership  and make the balance of the contract 0.
// => So we will call the contribute function and make a deposit of 1 wei it will help us when we use calldata 
// => Now we will do a direct call to the contract using calldata where will pass 1 wei with empty data which will trigger the receive function and now we have to match the criteria
// => WE need msg.value greater than 0 which we will checkmark with 1 wei as it is greater than 0 and other is we should have a contribution greater than 0 
// => Remember the contribution we made of 1 wei will checkmark this condition and Now we are the owner


contract Fallback {
    mapping(address => uint256) public contributions;
    address public owner;

    constructor() {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
}