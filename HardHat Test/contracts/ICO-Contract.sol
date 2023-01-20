// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title An ICO Contract that distributes the token among public if the preSale is active
 * buyers are divided into whitelist users & common public
 */
contract ICO is Ownable {
    /// @dev store the total supply of token in this variable
    uint256 public totalSupply;
    /// @dev store the start time of preSale in the variable
    uint256 public startTime;
    /// @dev store the wallet owner's address in this variable, this address will release funds
    address payable ownerWallet;

    /// @dev store the trade rate at which tokens will be given to whitelist & common users
    uint256 foundersProfitRate = 5;
    uint256 crowdSaleProfitRate = 2;

    /// @dev Pass the address of the token Contract you want to transfer tokens from
    IERC20 token;

    /// @dev this variable stores the total amount of funds collected by trading tokens
    uint256 public fundsRaised;

    /**
     * @notice this modifier only lets the buyers buy tokens when preSale is active
     */
    modifier preSaleActive() {
        require(block.timestamp < startTime + 5000, "PreSale is ended");
        _;
    }

    /// @notice notifies who invests how much
    event fundsRecieved(address investor, uint256 amount);
    /// @notice notifies if thr investor has collected his profit or not
    event profitCollected(address investor, uint256 profitAmount);

    /** @notice Deploys the token contract before this one
     *@dev sets wallet of `msg.sender` as the owner's wallet
     * @dev sets totalSupply of token from the user
     *@dev sets wallet of `msg.sender` as the owner's wallet
     *  @dev gets totalSupply of token from the user
     * @notice this will check if zero address is passed as the owner of the contract
     **/
    constructor(
        address payable _ownerWallet,
        IERC20 _token,
        uint256 _totalSupply
    ) {
        require(_ownerWallet != address(0));

        startTime = block.timestamp;
        ownerWallet = _ownerWallet;
        token = _token;
        totalSupply = _totalSupply;
    }

    uint256 publicTokens;
    uint256 founderTokens;

    function getTotalPublicTokens() public returns (uint256) {
        publicTokens = (totalSupply / 100) * 75;
        return publicTokens;
    }

    uint256 max = getTotalPublicTokens();

    function getTotalFounderTokens() public returns (uint256) {
        founderTokens = (totalSupply / 100) * 25;
        return founderTokens;
    }

    function getAvailablePercentageOfFounderTokens() public returns (uint256) {
        uint256 developerTokens;

        if (block.timestamp <= startTime + 500) {
            developerTokens = (getTotalFounderTokens() / 100) * 20;
        } else if (block.timestamp <= startTime + 1000) {
            developerTokens = (getTotalFounderTokens() / 100) * 40;
        } else {
            developerTokens = (getTotalFounderTokens() / 100) * 40;
        }
        return developerTokens;
    }

    function getAvailablePercentageOfPublicTokens() public returns (uint256) {
        uint256 commonTokens;

        if (block.timestamp <= startTime + 500) {
            commonTokens = (getTotalPublicTokens() / 100) * 20;
        } else if (block.timestamp < startTime + 1000) {
            commonTokens = (getTotalPublicTokens() / 100) * 40;
        } else {
            commonTokens = (getTotalPublicTokens() / 100) * 40;
        }
        return commonTokens;
    }

    mapping(address => uint256) fundsInvested;
    mapping(address => uint256) profitDue;
    address[] public whitelistInvesters;

    function addWhitelistInvester(address investor) public onlyOwner {
        whitelistInvesters.push(investor);
    }

    //The investor will input the price in Wei
    function invest() public payable preSaleActive {
        require(msg.value > 0);
        fundsInvested[msg.sender] = msg.value;

        ownerWallet.transfer(msg.value);

        fundsRaised += msg.value;

        uint256 profit;

        for (uint256 i = 0; i < whitelistInvesters.length; i++) {
            if (whitelistInvesters[i] == msg.sender) {
                profit = msg.value * foundersProfitRate;
            } else {
                profit = msg.value * crowdSaleProfitRate;
            }
        }

        profitDue[msg.sender] = profit;
        emit fundsRecieved(msg.sender, msg.value);
    }

    function collectProfit() public payable {
        require(fundsInvested[msg.sender] != 0, "You are not an investor");

        uint256 transferableTokens;
        for (uint256 i = 0; i < whitelistInvesters.length; i++) {
            if (whitelistInvesters[i] == msg.sender) {
                require(
                    profitDue[msg.sender] <=
                        getAvailablePercentageOfFounderTokens(),
                    "Not enough tokens left to award, Please wait for the next phase."
                );
                transferableTokens = profitDue[msg.sender];
                founderTokens -= transferableTokens;
            } else {
                require(
                    profitDue[msg.sender] <=
                        getAvailablePercentageOfPublicTokens(),
                    "Not enough tokens left to award, Please wait for the next phase."
                );
                transferableTokens = profitDue[msg.sender];
                publicTokens -= transferableTokens;
            }
        }

        token.transfer(msg.sender, transferableTokens);
        emit profitCollected(msg.sender, transferableTokens);
    }
}
