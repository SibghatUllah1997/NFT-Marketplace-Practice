// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
//import "@openzeppelin/contracts@4.8.0/token/ERC20/ERC20.sol";

contract NftMarketplace {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    event NFTListed(address indexed _owner, address indexed nftAddress);
    event ItemCanceled(address nftAddress);
    event ItemBought(address buyer, address nftAddress, uint256 price);


    struct NFTInfo {
        string URL;
        uint256 tokenId;
        uint256 supply;
        uint256 price;
        address payable _owner;
    }
    mapping(address => NFTInfo) NFTs;

    // Function Modifiers
    modifier alreadyListed(address _nftAddress) {
        require(NFTs[_nftAddress].supply == 0, "This NFT is already Listed");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner of this contract");
        _;
    }

    function listNFT(
        address nftAddress,
        string memory _URL,
        uint256 _tokenId,
        uint256 _supply,
        uint256 price,
        address payable _owner
    ) external alreadyListed(nftAddress) {
        require(price > 0, "Price should be greater than 0");

        NFTs[nftAddress] = NFTInfo(_URL, _tokenId, _supply, price, _owner);
        emit NFTListed(_owner, nftAddress);
    }

    function cancelListing(address nftAddress) external {
        delete NFTs[nftAddress];
        emit ItemCanceled(nftAddress);
    }

    function buyItem(address nftAddress, uint256 mintAmount) public payable {
        require(
            msg.sender.balance >= NFTs[nftAddress].price,
            "You do not have enough balance to Buy this NFT"
        );
        require(NFTs[nftAddress].supply > 0, "This NFT is sold out");
        require(NFTs[nftAddress].supply - mintAmount >= 0, "Not enough supply");

        IERC20 payingToken; 

        uint256 paymentDue = mintAmount * NFTs[nftAddress].price;

        for (uint256 i; i <= mintAmount; i++) {
            IERC721(nftAddress).safeTransferFrom(   
                msg.sender,
                NFTs[nftAddress]._owner,
                NFTs[nftAddress].tokenId
            );
        }
        payingToken.transferFrom(
            NFTs[nftAddress]._owner,
            msg.sender,
            paymentDue
        );
        emit ItemBought(msg.sender, nftAddress, NFTs[nftAddress].price);

        NFTs[nftAddress].supply -= mintAmount;
    }

    //get information about the NFTs listed

    function getNFTInfo(address nftAddress)
        external
        view
        returns (NFTInfo memory)
    {
        return NFTs[nftAddress];
    }
}

