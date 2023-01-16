// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ICO is Ownable {
    uint256 public totalSupply;
    uint256 public foundersTokens = 25000;
    uint256 public crowdSaleTokens = 75000;
    uint256 public foundersProfitRate;
    uint256 public crowdSaleProfitRate;
    address payable ownerWallet;

    uint256 preSaleTime = block.timestamp + 1000;
    ERC20 token;

    uint256 public fundsRaised;

    modifier preSaleActive() {
        require(block.timestamp < preSaleTime, "PreSale is ended");
        _;
    }

    constructor(
        address payable _ownerWallet,
        ERC20 _token,
        uint256 _foundersProfitRate,
        uint256 _crowdSaleProfitRate,
        uint256 _totalSupply
    ) {
        require(_foundersProfitRate > 0);
        require(_ownerWallet != address(0));

        foundersProfitRate = _foundersProfitRate;
        crowdSaleProfitRate = _crowdSaleProfitRate;
        ownerWallet = _ownerWallet;
        token = _token;
        totalSupply = _totalSupply; //100000;
    }

    struct profitToInvester {
        uint256 profit;
        uint256 lockedTime;
    }

    mapping(address => uint256) fundsInvested;
    address[] public whitelistInvesters;
    mapping(address => profitToInvester) profitDue;

    function addWhitelistInvester(address investor) public onlyOwner {
        whitelistInvesters.push(investor);
    }

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

        profitDue[msg.sender] = profitToInvester(profit, block.timestamp + 30);
    }

    function collectProfit() public payable {
        require(fundsInvested[msg.sender] != 0, "You are not an investor");

        require(
            profitDue[msg.sender].lockedTime < block.timestamp,
            "You're not eligible to retrieve tokens just yet"
        );

        for (uint256 i = 0; i < whitelistInvesters.length; i++) {
            if (whitelistInvesters[i] == msg.sender) {
                require(
                    profitDue[msg.sender].profit <= foundersProfitRate,
                    "Not enough tokens left to award"
                );
                foundersProfitRate -= profitDue[msg.sender].profit;
            } else {
                require(
                    profitDue[msg.sender].profit <= crowdSaleTokens,
                    "Not enough tokens left to award"
                );
                crowdSaleTokens -= profitDue[msg.sender].profit;
            }
        }

        token.transfer(msg.sender, profitDue[msg.sender].profit);
    }
}
