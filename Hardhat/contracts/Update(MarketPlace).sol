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
        address Seller;
        uint256 ProductId;
        uint256 price;
        uint256 Amount;
        // bytes  Data;
        // bool deliviered;
    }
    string baseURI;
    uint256 Counter;
    uint256 Compare;
    IERC20 PaymentTokens;

    event registered(string TITLE, uint256 ProductID, address Seller);
    event bought(uint256 ProductId, address Buyer);
    event DelivieredProduct(uint256 ProductId);

    

    constructor(string memory _baseURI) ERC1155("") {
        baseURI = _baseURI;
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
    mapping(uint=>Product) public ProductDetail;
    function _GenrateNFT(
         string memory _title,
         string memory _Descr,
         string memory _URI,
         address account,
         uint256 _ProductId,
         uint256 _price,
         uint256 amount
        //  bytes memory data
         ) public onlyOwner {
         require(_price > 0, "Price is not sufficent");
         ProductDetail[_ProductId]=Product(_title,_Descr,_URI,account,_ProductId,_price, amount);
         emit registered(_title,_ProductId, msg.sender);
    //     Compare = id;
     }

    function ListProduct(
        // string memory _title,
        // string memory _Descr,
        uint256 _price,
        // string memory _URI,
        uint256 _ProductId
    ) public {
        require(_price > 0, "Price is not sufficent");
        require(_ProductId == Compare, "The entery is not valid");
    }
    // function ShowItem(uint _ProductId)public view returns(Product memory){
    //  return ProductDetail[_ProductId];
    // }
    function buy(uint256 _productId) public payable {

    }
}