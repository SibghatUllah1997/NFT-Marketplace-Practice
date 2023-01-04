// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFTPractice is ERC1155, Ownable {
    struct Product {
        string title;
        string Descr;
        string URI;
        address payable Seller;
        uint256 ProductId;
        uint256 price;
        address Buyer;
        bool deliviered;
    }
    string baseURI;
    uint256 Counter;
    uint256 Compare;
    IERC20 PaymentTokens;

    event registered(string TITLE, uint256 ProductID, address Seller);
    event bought(uint256 ProductId, address Buyer);
    event DelivieredProduct(uint256 ProductId);

    Product[] public products;

    constructor(string memory _baseURI) ERC1155("") {
        baseURI = _baseURI;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(
        address account,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public onlyOwner {
        _mint(account, id, amount, data);
        Compare = id;
    }

    function ListProduct(
        string memory _title,
        string memory _Descr,
        uint256 _price,
        string memory _URI,
        uint256 _ProductId
    ) public {
        require(_price > 0, "Price is not sufficent");
        require(_ProductId == Compare, "The entery is not valid");
        Product memory temporaryproduct;
        temporaryproduct.title = _title;
        temporaryproduct.Descr = _Descr;
        temporaryproduct.price = _price * 10**18;
        temporaryproduct.URI = _URI;
        temporaryproduct.Seller = payable(msg.sender);
        products.push(temporaryproduct);
        Counter++;
        emit registered(_title, temporaryproduct.ProductId, msg.sender);
    }

    function buy(uint256 _productId) public payable {}
}
