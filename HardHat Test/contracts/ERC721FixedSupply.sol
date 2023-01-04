// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

pragma solidity ^0.8.0;

contract Collection is ERC721Enumerable, Ownable {
    struct TokenInfo {
        IERC20 paytoken;
        uint256 costvalue;
    }

    TokenInfo[] public AllowedCrypto;

    struct NFTInfo {
        string URL;
        uint256 supply;
        address _owner;
    }

    mapping(uint256 => NFTInfo) NFTs;

    using Strings for uint256;
    string public baseURI;
    string public baseExtension = ".json";
    bool public paused = false;

    constructor() ERC721("HyfaTech NFT Collection", "HFT") {}

    function addCurrency(IERC20 _paytoken, uint256 _costvalue)
        public
        onlyOwner
    {
        AllowedCrypto.push(
            TokenInfo({paytoken: _paytoken, costvalue: _costvalue})
        );
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/";
    }

    function addNFT(
        uint256 _id,
        string memory _URL,
        uint256 _supply,
        address _owner
    ) public onlyOwner {
        NFTs[_id] = NFTInfo(_URL, _supply, _owner);
    }

    function buyNFT(
        uint256 _id,
        address _to,
        uint256 _mintAmount,
        uint256 _pid
    ) public payable {
        TokenInfo storage tokens = AllowedCrypto[_pid];
        IERC20 paytoken;
        paytoken = tokens.paytoken;
        uint256 cost;
        cost = tokens.costvalue;
        require(!paused);
        require(NFTs[_id].supply > 0);
        require(_mintAmount <= NFTs[_id].supply);

        if (msg.sender != owner()) {
            require(
                msg.value == cost * _mintAmount,
                "Not enough balance to complete transaction."
            );
        }

        for (uint256 i = 1; i <= _mintAmount; i++) {
            paytoken.transferFrom(msg.sender, address(this), cost);
            _safeMint(_to, _id);
        }

        NFTs[_id].supply -= _mintAmount;
    }

    function walletOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension)
        public
        onlyOwner
    {
        baseExtension = _newBaseExtension;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw(uint256 _pid) public payable onlyOwner {
        TokenInfo storage tokens = AllowedCrypto[_pid];
        IERC20 paytoken;
        paytoken = tokens.paytoken;
        paytoken.transfer(msg.sender, paytoken.balanceOf(address(this)));
    }
}
