// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract stateVariable {
    // state variables
    uint256 public salary;

    // constructor
    constructor() {
        salary = 1000;
    }

    function setSalary() public {
        salary = 2000;
    }
}
