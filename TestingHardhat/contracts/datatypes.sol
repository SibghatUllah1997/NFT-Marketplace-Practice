// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// data types - values & references
contract valueTypes{
    bool public boolTrue = true;
    bool public boolFalse = false;
    
    uint public temp = 243; // uint256 -> 0 - 2^(256)-1

    int public temp2 = 123; // int256 -> -2^255 to 2^255 - 1

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // 160 bits/20 bytes -> hexa

    bytes32 public b32; // 32 bytes


}