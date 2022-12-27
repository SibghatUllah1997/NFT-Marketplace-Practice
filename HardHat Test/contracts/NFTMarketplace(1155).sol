// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract HyfaToken is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private Nfts;

    string public baseURI;
    IERC20 paymentToken;

    constructor(string memory _URI) ERC1155("") { 
        baseURI = _URI;
    }

    function updateURI(string memory uri) public {
        baseURI = uri;
    }

    struct NFTInfo {
        string URI;
        address nftAddress;
        uint256 supply;
        uint256 price;
        address payable _owner;
    }
    mapping(uint256 => NFTInfo) NFTs;
    mapping(uint256 => mapping(uint256 => bool)) listedNFTs;
    uint[] listedNfts;

    uint256 public totalNfts;

    function changeURI(string memory uri) public {
        _setURI(uri);
    }

    function mintNFT(
        address nftAddress,
        string memory _URL,
        uint256 _supply,
        uint256 price,
        address payable _owner
    ) public onlyOwner {
        require(price > 0, "Price should be greater than 0");

        NFTs[totalNfts] = NFTInfo(_URL, nftAddress, _supply, price, _owner);
        _mint(msg.sender, totalNfts, _supply, "");
        totalNfts++;
    }

    function listNFT(uint256 tokenId, uint256 amount) external {
        require(NFTs[tokenId].price != 0, "This NFT is not minted yet");
        require(balanceOf(msg.sender, tokenId) > amount, "You do not own enough tokens"); 
        listedNFTs[tokenId][amount] = true;
        listedNfts.push(amount);
    }

    function buyNFT(uint256 tokenId, uint256 amount) public payable {
        require(amount <= NFTs[tokenId].supply, "Not enough supply left");
        require(
            listedNFTs[tokenId][amount] == true,
            "The token you're trying to buy is not listed"
        );

        safeTransferFrom(NFTs[tokenId]._owner, msg.sender, tokenId, amount, "");

        uint256 amountPayable = amount * NFTs[tokenId].price;
        require(msg.value >= amountPayable, "Please send enough funds");

        paymentToken.transfer(NFTs[tokenId]._owner, amountPayable);
    }
}