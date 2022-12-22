// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract functionIntro {
    uint256 public age = 20;

    function add(uint256 _x, uint256 _y) public pure returns (uint256) {
        return _x + _y;
    }

    function changeAge() public {
        age += 1;
    }

    function getAge() public view returns (uint256) {
        return age;
    }

    function fun() public {
        // code
    }
}

function dummy(uint256 _x) pure returns (uint256) {
    return _x * 10;
}
