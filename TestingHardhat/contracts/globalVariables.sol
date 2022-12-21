// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract globalVariables {
    address public myAdd = msg.sender;
    uint256 public time = block.timestamp;
    uint256 public diff = block.difficulty;
    uint256 public gasCost = tx.gasprice;

    
}
