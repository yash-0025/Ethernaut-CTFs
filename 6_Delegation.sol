// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



//////// @title Solution Delegation
/// @author  Yash Patel

// Q.] Get the ownership
// We will see how the owner is being set as we can see there is an instance of Delegate in the delegation contract
// But there is no function in the Delegation contract but there is a fallback function declared in the delegation contract 
// And the fallback function make a delegateCall but using the Delegate contract instance .
// If we look at the Delegate contract it has a pwm function which changes the owner.
// So now we will call the pwn function via Delegation Contract as there is no function in the Delegation contract it will trigger the fallback function 
// So when we does that msg.data will contains the pwn function selector so it will make a delegatecall to pwn() function in the Delegate contract
// Which sets the msg.sender as the owner so 
// We are the owner now

contract Delegate {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;

    constructor(address _delegateAddress) {
// Delegate contract instance.
        delegate = Delegate(_delegateAddress);
        owner = msg.sender;
    }

    fallback() external {
        (bool result,) = address(delegate).delegatecall(msg.data);
        if (result) {
            this;
        }
    }
}