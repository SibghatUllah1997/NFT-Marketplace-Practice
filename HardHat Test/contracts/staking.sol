// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//import "@openzeppelin/contracts@4.8.0/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Staking {
    IERC20 _token;
    address ownerT;

    // tokenContract = Contract Address of the Token wihich is to be staked
    constructor(address tokenContract) {
        ownerT = msg.sender;
        _token = IERC20(tokenContract);
    }

    using SafeMath for uint256;

    uint256 public minStakingAmount = 0.1 ether;

    struct staking {
        uint256 amount;
        uint256 stakeTime;
    }

    mapping(address => mapping(uint256 => staking)) stakedDetails;

    // This function adds the staker-member
    
    function stakeTokens(
        address _staker,
        uint256 _amount,
        uint256 _stakeTime,
        uint256 _orderOfStake //this variable holds the no of times this user has staked
    ) public {
        require(
            address(_staker).balance > minStakingAmount,
            "You do not have enough to stake"
        );

        stakedDetails[_staker][_orderOfStake] = staking(
            _amount,
            block.timestamp + _stakeTime
        );
        _token.transferFrom(msg.sender, address(this), _amount);
    }

    // This function release the claimed rewards to stakers
    function claimTokens(address payable _staker, uint256 _orderOfStake)
        public
    {
        require(
            block.timestamp > stakedDetails[_staker][_orderOfStake].stakeTime,
            "Staked time is not over yet"
        );

        uint256 stakeAmount = stakedDetails[_staker][_orderOfStake].amount;
        uint256 stakedTime = stakedDetails[_staker][_orderOfStake].stakeTime;
        uint256 rewardTokens = stakeAmount + ((stakeAmount * stakedTime) / 100);
        _token.transferFrom(_staker, address(this), rewardTokens);
    }
}