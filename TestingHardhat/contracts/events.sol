// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Event {
    event balance(address account, string message, uint256 val);

    function setData(uint256 _val) public {
        emit balance(msg.sender, "has a", _val);
    }
}

contract chatApp {
    event chat(address _from, address _to, string _message);

    function sendMsg(address to_, string memory message_) public {
        emit chat(msg.sender, to_, message_);
    }
}
