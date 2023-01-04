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
        uint TotalSupply;
        uint TPrice;
    }
    uint256 Counter = 1;
    uint256 Quantity;
    event registered(string TITLE, uint256 ProductID, address Seller);
    event bought(uint256 ProductId, address Buyer);
    event DelivieredProduct(uint256 ProductId);
    // for store multiple product which having all Struct properties in a Array we use
    Product[] public products;

    // make a function to reigester your Product
    function RegisterProduct(
        string memory _title,
        string memory _Descr,
        uint256 _price        
        // uint256 _TotalSupply
        // uint256 _TPrice
    ) public {
        // we are going to made that our price should not be 0 or greater than zero
        require(_price > 0, "Price is not sufficent");
        // we are going to made a temporary copy in memory
        Product memory temporaryproduct;
        //  require( _TotalSupply>= _Quantity, "Your Quantity should be less than or equal to your Total Supply");
        temporaryproduct.title = _title;
        temporaryproduct.Descr = _Descr;
        //  temporaryproduct.TotalSupply=_TotalSupply;
        temporaryproduct.price = _price * 10**18;
        Quantity=temporaryproduct.price;
        // temporaryproduct.TPrice = _price * 10**18*_TotalSupply; // converting the Total 7   price in Wei using this cal
        
        temporaryproduct.Seller = payable(msg.sender);
        temporaryproduct.ProductId = Counter; //to genrate the ProductID
        // we made this in a temporary memory after that we should push that in our Array temporaryproduct
        products.push(temporaryproduct);
        Counter++; //every time we increment in a counter
        emit registered(_title, temporaryproduct.ProductId, msg.sender);
    }

    function buy(uint256 _productId, uint256 _TotalSupply) public payable {
        //we are going to check the price which the buyer pay is equal to the value (ether)which is the actuall price of the Product
       
        products[_productId - 1].TotalSupply=_TotalSupply;
        products[_productId - 1].TPrice = Quantity * 10**18* products[_productId - 1].TotalSupply;
        //we are set that the Seller can't be a buyer
         require(
            products[_productId - 1].price == msg.value,
            "please Pay the exact price"
        );
        require(
            products[_productId - 1].Seller != msg.sender,
            "Seller is not a Buyer"
        );
        //we are setting the buyer to the current product
        products[_productId - 1].Buyer = msg.sender;
        emit bought(_productId, msg.sender);
    }

    function deliver(uint256 _productId) public {
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
