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
    }
    bytes32 Verification;
    string baseURI;
    uint256 Counter;
    uint256 Compare;
    uint256 TotalPrice;
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

    mapping(uint256 => Product) public ProductDetail;
    mapping(uint256 => mapping(uint256 => bool)) ListItem;
    uint256[] public List;

    function _GenrateNFT(
        string memory _title,
        string memory _Descr,
        string memory _URI,
        address account,
        uint256 _ProductId,
        uint256 _price,
        uint256 amount
    ) public onlyOwner {
        require(_price > 0, "Price is not sufficent");
        _mint(account, _ProductId, amount, "");
        ProductDetail[_ProductId] = Product(
            _title,
            _Descr,
            _URI,
            account,
            _ProductId,
            _price,
            amount
        );
        
        emit registered(_title, _ProductId, msg.sender);
        Counter++;
    }

    function ListProduct(uint256 _Amount, uint256 _ProductId) public {
        require(ProductDetail[_ProductId].price > 0, "Price is not sufficent");
        require(
            ProductDetail[_ProductId].Amount >= _Amount,
            "you have Insufficent Tokens"
        );
        ListItem[_ProductId][_Amount] = true;
        List.push(_ProductId);
    }

    function ShowItem(uint256 _ProductId) public view returns (Product memory) {
        return ProductDetail[_ProductId];
    }

    // function Sale(uint256 _ProductId , uint AmountNft, address _to) public payable {

    // TotalPrice=ProductDetail[_ProductId].price*ProductDetail[_ProductId].Amount;
    // require(TotalPrice<=msg.value,"Price is not sufficent");
    // safeTransferFrom(msg.sender,_to,_ProductId,AmountNft,"");

    function Sale(
        uint256 _ProductId,
        uint256 AmountNft,
        address _to,
        string memory _title
    ) public payable returns (bytes32) {
        require(
            ProductDetail[_ProductId].Amount >= AmountNft,
            "you have Insufficent Tokens"
        );
        // TotalPrice=ProductDetail[_ProductId].price*ProductDetail[_ProductId].Amount;
        // require(TotalPrice<=msg.value,"Price is not sufficent");
        safeTransferFrom(msg.sender, _to, _ProductId, AmountNft, "");
        return
        Verification = keccak256(
                abi.encodePacked(
                    abi.encodePacked(_ProductId, AmountNft, _to, _title)
                )
            );
    }

    function Purchase(
        uint256 _ProductId,
        address payable _to,
        uint256 AmountNft,
        bytes memory signature
       

    ) public payable returns (bool) {
        TotalPrice = ProductDetail[_ProductId].price * 10 * 18 * AmountNft;
        require(TotalPrice <= msg.value, "Price is not sufficent");
        PaymentTokens.transfer(_to, TotalPrice);
         return recoverSign(Verification, signature) == _to;
    }
     function recoverSign(bytes32 GetmessageHash, bytes memory _signature)
        public
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(GetmessageHash, v, r, s);
    }
    function splitSignature(bytes memory sig)
        public
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        require(sig.length == 65, "invalid signature length");

        assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        // implicitly return (r, s, v)
    }

    function Listdis() public view returns (uint256[] memory) {
        return List;
    }
}

//TotalPrice=ProductDetail[_ProductId].price*ProductDetail[_ProductId].Amount