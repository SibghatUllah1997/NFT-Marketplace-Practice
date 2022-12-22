// SPDX-License-Identifier: MIT
pragma solidity >0.7.0;

contract hub{
    string public company;
    uint  public salary;
    constructor(string memory Name, uint employee ){
    company=Name;
    salary=employee;
    }
}