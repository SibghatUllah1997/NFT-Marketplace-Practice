// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMintingListing is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private Nfts;
    string public baseURI;

    event NFTMinted(uint256 tokenId, uint256 amount, uint256 price);
    event NFTListed(uint256 tokenId, uint256 amount);

    constructor(string memory _URI) ERC1155("") {
        baseURI = _URI;
    }


    //This function updates the pre-fetched URI
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
    
    mapping(uint256 => NFTInfo) public NFTs;
    mapping(uint256 => mapping(uint256 => bool)) public listedNFTs;
    uint256[] listedNfts;

    uint256 public totalNfts;

    //Creates NFTs for the users to mint later
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

        emit NFTMinted(totalNfts, _supply, price);
        totalNfts++;
    }

    //Users can decide which NFTs to list & in what amount
    function listNFT(uint256 tokenId, uint256 amount) external {
        require(NFTs[tokenId].price != 0, "This NFT is not minted yet");
        require(
            balanceOf(msg.sender, tokenId) > amount,
            "You do not own enough tokens"
        );
        listedNFTs[tokenId][amount] = true;
        listedNfts.push(amount);

        emit NFTListed(tokenId, amount);
    }
}
