// SPDX-License-Identifier: MIT
pragma solidity >0.7.4;
contract jeko{
    string public name;
    uint public rollno;
    uint public marks;
    constructor (string memory _name,uint _rollno,uint _marks){
        name=_name;
        rollno=_rollno;
        marks=_marks;
    }
}

