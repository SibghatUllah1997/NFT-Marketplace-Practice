// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract viewPureSimpleFunc {
    uint256 public age = 20;

    function viewFunc() public view returns (uint256) {
        return age;
    }

    function pureFunc1() public pure returns (uint256) {
        return 1;
    }

    function pureFunc2(uint256 _x) public pure returns (uint256) {
        return _x;
    }

    function simpleFunc() public {
        age = age + 10;
    }
}
