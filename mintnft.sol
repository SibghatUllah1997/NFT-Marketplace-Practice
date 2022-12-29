//SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NftMarketplace is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private Nfts;
    IERC20 paymenttoken;

    function updateURI(string memory uri) public {
        baseURI = uri;
    }

    struct NFTinfo {
        string URI;
        address nftAddress;
        uint256 supply;
        uint256 price;
        address payable _owner;
    }
    mapping(uint256 => NFTInfo) NFTs;
    mapping(uint256 => mapping(uint256 => bool)) listedNFTs;
    uint256[] listedNfts;

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
        require(price > 0, "");

        NFTs[totalNfts] = NFTInfo(_URL, nftAddress, _supply, price, _owner);
        _mint(msg.sender, totalNfts, _supply, "10");
        totalNfts++;
    }
}