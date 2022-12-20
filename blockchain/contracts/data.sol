// SPDX-License-Identifier: MIT
pragma solidity >0.7.0;
contract student{
    string public name;
    uint public rollno;
    uint public marks;
    constructor(string memory nm, uint rn, uint mk){
        name = nm;
        rollno = rn;
        marks = mk;
    }

}
