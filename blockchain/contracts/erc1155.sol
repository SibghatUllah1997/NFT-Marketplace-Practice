//SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract NftMarketPlace is Ownable {
    using Counters for Counters.Counter;
    Counters.Counter _solditem;

    mapping(uint256 => string) internal _tokenURI;
    mapping(string => uint256) private idtoproductname;

    event product(string _name, uint256 _tokenid, uint256 _price, bool sold);

    struct Items {
        string Name;
        string tokenid;
        uint256 price;
        address payable seller;
        address buyer;
        bool sold;
    }

    function setUri(string memory _newuri) public onlyOwner {
        setUri(_newuri);
    }

    function mintToken(
        string memory tokenuri,
        uint256 amount,
        uint256 price
    ) public returns (uint256) {}
}
