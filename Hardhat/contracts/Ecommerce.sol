//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Ecommerce {
    //we are going to declare a Struct because we are dealing with multiple datatypes
    struct Product {
        string title;
        string Descr;
        address payable Seller;
        uint256 ProductId;
        uint256 price;
        address Buyer;
        bool deliviered;
    }
    uint256 Counter = 1;
    event registered(string TITLE, uint256 ProductID, address Seller);
    event bought(uint256 ProductId, address Buyer);
    event DelivieredProduct(uint256 ProductId);
    // for store multiple product which having all Struct properties we use
    Product[] public products;

    // make a function to reigester your Product
    function RegisterProduct(
        string memory _title,
        string memory _Descr,
        uint256 _price
    ) public {
        // we are going to made that our price should not be 0 or greater than zero
        require(_price > 0, "Price is not sufficent");
        // we are going to made a temporary copy in memory
        Product memory temporaryproduct;
        temporaryproduct.title = _title;
        temporaryproduct.Descr = _Descr;
        temporaryproduct.price = _price * 10**18; // converting the price in Wei using this cal
        temporaryproduct.Seller = payable(msg.sender);
        temporaryproduct.ProductId = Counter; //to genrate the ProductID
        // we made this in a temporary memory after that we should push that in our Array temporaryproduct
        products.push(temporaryproduct);
        Counter++; //every time we increment in a counter
        emit registered(_title, temporaryproduct.ProductId, msg.sender);
    }

    function buy(uint256 _productId) public payable {
        //we are going to check the price which the buyer pay is equal to the value (ether)which is the actuall price of the Product
        require(
            products[_productId - 1].price == msg.value,
            "please Pay the exact price"
        );
        //we are set that the Seller can't be a buyer
        require(
            products[_productId - 1].Seller != msg.sender,
            "Seller is not a Buyer"
        );
        //we are setting the buyer to the current product
        products[_productId - 1].Buyer = msg.sender;
        emit bought(_productId, msg.sender);
    }

    function diliver(uint256 _productId) public {
        require(
            products[_productId - 1].Buyer == msg.sender,
            "buyer can confirm it"
        );
        products[_productId - 1].deliviered = true;
        products[_productId - 1].Seller.transfer(
            products[_productId - 1].price
        );
        emit DelivieredProduct(_productId);
    }
}
