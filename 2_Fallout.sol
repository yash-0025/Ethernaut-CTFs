// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "openzeppelin-contracts-06/math/SafeMath.sol";


//////// @title Solution Fallout
/// @author  Yash Patel

// => Here the contract is using the solidity version 6.0 in which constructor can be declared as the name of the contract name
// => But if you look here there is a similar function but there's a slight change as the contract name is Fallout and function which helps changing the owner is Fal1out
// => Now we can call that function and achieve the owner relo
// => For that we will create an interface of Fallout contract and declare 2 function one to check owner and other is Fal1out and we will use that interface on the deployed address of Fallout.
// => We can call Fal1out function and we will be the owner

contract Fallout {
    using SafeMath for uint256;

    mapping(address => uint256) allocations;
    address payable public owner;

    /* constructor */
    function Fal1out() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function allocate() public payable {
        allocations[msg.sender] = allocations[msg.sender].add(msg.value);
    }

    function sendAllocation(address payable allocator) public {
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return allocations[allocator];
    }
}