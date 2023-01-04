// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./mintingNFT.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFTMarketplace is ERC1155 {

    IERC20 paymentToken;
    NFTMintingListing NFt;

    event NFTSold(uint256 tokenId, uint256 amount, address buyer);

    constructor(address secondContractAddress) ERC1155("") {
        NFt = NFTMintingListing(secondContractAddress);
    }

    function buyNFT(uint256 tokenId, uint256 amount) public payable {
        require(amount <= NFTMintingListing.NFTs[tokenId].supply, "Not enough supply left");
        require(
            NFt.listedNFTs[tokenId][amount] == true,
            "The token you're trying to buy is not listed"
        );

        safeTransferFrom(
            NFt.NFTs[tokenId]._owner,
            msg.sender,
            tokenId,
            amount,
            ""
        );

        uint256 amountPayable = amount * NFt.NFTs[tokenId].price;
        require(msg.value >= amountPayable, "Please send enough funds");

        paymentToken.transfer(NFt.NFTs[tokenId]._owner, amountPayable);

        emit NFTSold(tokenId, amount, msg.sender);
    }
}
