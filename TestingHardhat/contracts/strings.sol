// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract strings {
    string public str = "Ali Uppal"; // state variable

    function checkString(string memory _str)
        public
        pure
        returns (string memory)
    {
        string memory name = _str;
        return name;
    }
}
