// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//////// @title Solution Vault
/// @author  Yash Patel

// Q.] We have to get the password to unlock the vault
// => The problem here is we didn't know the password and to unlock the vault we need password and there is no public view function to get the password directly
// => So here we have to look at the storage as the contract stores the data in storage slot and if we can see there is a state variable which stores the password
// => As it shows private but it only stops it accessibility we can still view it in storage
// => So there can be two ways we can do that 
// => But before that we have to find the storage slot of the password variable
// => Each slot can store upto 32 bytes so at slot 0 there will be boolen locked variable and at slot 2 we can find password
// => 1.] We can use web3.eth.getStorageAt(contractaddress, storageslotno)
// => 2.] cast storage contractAddress --rpc-url rpc-url-of-the-network
// => After getting the password we can just pass that value in the unlock function and vault will gets unlocked

contract Vault {
    bool public locked;
    bytes32 private password;

    constructor(bytes32 _password) {
        locked = true;
        password = _password;
    }

    function unlock(bytes32 _password) public {
        if (password == _password) {
            locked = false;
        }
    }
}