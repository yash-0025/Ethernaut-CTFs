// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;



//////// @title Solution Token
/// @author  Yash Patel

// Q.] We have to increase our balance atleast by 1 token we have 20 token balance as of now
// => AS we can see in the token contract it maps the balances of the users and it uses solidity version 0.6 which has rounding issues
// => Now there is a transfer function which checks the balance before transferring tokens but there's a problem lying there.
// => If we have balance 0 and we try to send let's suppose 1 token it will underflow as it will becomes 0 - 1 so it will become max uint
// => So we have to call the transfer function where we can set the to address as our account address but to do that we should have an instance of the Toekn contract so we can use this function in our contract
// => Now we will create a interface of Token contract where we can check balance and call transfer fucntion 
// => Then we will create a contract where we will set to address as our address by msg.sender and we can enter any value we want to transfer
// => Suppose we enter the value 1 now we will have 21 token in our wallet

contract Token {
    mapping(address => uint256) balances;
    uint256 public totalSupply;

    constructor(uint256 _initialSupply) public {
        balances[msg.sender] = totalSupply = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balances[msg.sender] - _value >= 0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }
}