// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.0/token/ERC20/IERC20.sol";

contract HelloWorld {
    uint256 public rewardPerSec;
    address public rewardToken;

    constructor(uint256 _rewardPerSec, address _rewardToken) {
        rewardPerSec = _rewardPerSec;
        rewardToken = _rewardToken;
    }

    struct UserInfo {
        uint256 timeine;
        uint256 timeOut;
        uint256 amountStaked;
    }

    mapping(address => UserInfo) public userInfo;

    function stake(uint256 amount, address token) public {
        userInfo[msg.sender].timeine = block.timestamp;
        userInfo[msg.sender].amountStaked = amount;
        IERC20(token).transferFrom(msg.sender, address(this), amount);
    }

    function withdrawal(address token) public {
        userInfo[msg.sender].timeOut = block.timestamp;
        uint256 duration = userInfo[msg.sender].timeOut -
            userInfo[msg.sender].timeine;
        uint256 reward = duration * rewardPerSec;
        IERC20(token).transfer(msg.sender, userInfo[msg.sender].amountStaked);
        IERC20(rewardToken).transfer(msg.sender, reward);
    }
}
