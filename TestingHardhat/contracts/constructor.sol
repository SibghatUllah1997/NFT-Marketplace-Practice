// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Constructor {
    uint256 public age;
    address public owner;
    string public name;

    constructor() {
        age = 30;
    }
}
