//SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NftMarketplace is ERC1155, Ownable {
    IERC20 paymenttoken;

    struct nft {
        uint256 price;
        address seller;
    }

    function listItem(
        address nftAddress,
        uint256 tokenId,
        uint256 price
    ) public{}

    function updateListing(
        address nftAddress,
        uint256 tokenId,
        uint256 newPrice
    ) public{}

    function forward() public{} // method caller should be withdrawer
    
    function getListing(address nftAddress, uint256 tokenId)  public{}

    // State Variables
    mapping(address => mapping(uint256 => listed)) public _NFT;
    mapping(address => uint256) private s_forward;

    // Function
    function notListed(
        address nftAddress,
        uint256 tokenId,
        address owner
    ) {
        nft memory token = _NFT[nftAddress][tokenId];
        if (listing.price > 0) {
            return Alreadynft(nftAddress, tokenId);
        }
        _;
    }

    function (
        address nftAddress,
        uint256 tokenId,
        address spender
    // ) public Owner{
        // erc1155 NFTInfo = IERC20(paymentAddress);
        // address owner = nft.ownerOf(tokenId);
        if (spender != owner) {
            return Owner();
        }
        _;
    }

