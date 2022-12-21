// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract localVariables {
    uint256 public age;
    bool public b;
    address public newAdd;

    function fun(
        uint256 _age,
        bool _b,
        address _newAdd
    ) public returns (uint256, bool) {
        uint256 i = 29;
        bool b1 = true;

        i = i + 1;
        b1 = false;

        age = _age;
        b = _b;
        newAdd = _newAdd;

        return (i, b1);
    }
}
