// SPDX-License-Identifier: MIT
pragma solidity >0.7.0;
contract Cars{
    string public name;
    string public colour;
    uint public model;
    constructor(string memory nm,string memory cl, uint mdl){
        name = nm;
        colour=cl;
        model = mdl;
    }
}



