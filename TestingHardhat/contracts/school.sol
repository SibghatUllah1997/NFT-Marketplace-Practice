// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract student {
    string public name;
    uint public rollNo;
    uint public marks;

    constructor(string memory _name, uint _rollNo, uint _marks) {
        name = _name;
        rollNo = _rollNo;
        marks = _marks;
    }
}
