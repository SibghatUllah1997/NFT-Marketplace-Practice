// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// contract NFTPractice is ERC1155, Ownable {
   
//     struct Product {
//         string title;
//         string Descr;
//         string URI;
//         address Seller;
//         uint256 ProductId;
//         uint256 price;
//         uint256 Amount;
//     }

//     string baseURI;
//     uint256 Counter;
//     uint256 Compare;
//     uint256  TotalPrice;
//     IERC20 PaymentTokens;
//     IERC1155 NFTsTransfer;
    
//     event registered(string TITLE, uint256 ProductID, address Seller);
//     event bought(uint256 ProductId, address Buyer);
//     event DelivieredProduct(uint256 ProductId);

//     constructor(string memory _baseURI) ERC1155("") {
//         baseURI = _baseURI;
//     }

//     function setURI(string memory newuri) public onlyOwner {
//         _setURI(newuri);
//     }
//     mapping(uint=>Product) public ProductDetail;
//     mapping(uint256=>mapping(uint256 => bool)) ListItem;
//     uint [] public List;
    
//     function _GenrateNFT(
         
//          string memory _title,
//          string memory _Descr,
//          string memory _URI,
//          address account,
//          uint256 _ProductId,
//          uint256 _price,
//          uint256 amount

//          ) public onlyOwner {
//          require(_price > 0, "Price is not sufficent");
//          ProductDetail[_ProductId]=Product(_title,_Descr,_URI,account,_ProductId,_price, amount);
//          emit registered(_title,_ProductId, msg.sender);
//          Counter++;
   
//      }

//     function ListProduct(
        
//         uint256 _Amount,
//         uint256 _ProductId

//     ) public {
       
//         require(ProductDetail[_ProductId].price > 0, "Price is not sufficent");
//         require(ProductDetail[_ProductId].Amount >= _Amount ,"you have Insufficent Tokens");
//         ListItem [_ProductId][_Amount]=true;
//         List.push(_ProductId);
        
//     }
//     // function ShowItem(uint _ProductId)public view returns(Product memory){
//     //  return ProductDetail[_ProductId];
//     // }
//     // function Sale(uint256 _ProductId , uint AmountNft, address _to) public payable {
     
//     // // TotalPrice=ProductDetail[_ProductId].price*ProductDetail[_ProductId].Amount;
//     // require(TotalPrice<=msg.value,"Price is not sufficent");
//     // safeTransferFrom(msg.sender,_to,_ProductId,AmountNft,"");
    

//     // }

//     //  function Purchase(uint256 _ProductId , address _to ,uint AmountNft) public payable {
     
//     // TotalPrice=ProductDetail[_ProductId].price*AmountNft;

//     //  IERC20(PaymentTokens).transfer(_to, TotalPrice);
//     //  IERC20(PaymentTokens).transfer(_to, TotalPrice);
    
//     //  }

//     function Listdis() public view returns(uint[] memory){
//       return List;
//     }
  
// }

// contract MarketPlace is NFTPractice{
//  function Sale(uint256 _ProductId , uint AmountNft, address _to) public payable {
     
//     // TotalPrice=ProductDetail[_ProductId].price*ProductDetail[_ProductId].Amount;
//     require(TotalPrice<=msg.value,"Price is not sufficent");
//     safeTransferFrom(msg.sender,_to,_ProductId,AmountNft,"");
    

//     }

//      function Purchase(uint256 _ProductId , address _to ,uint AmountNft) public payable {
     
//     TotalPrice=ProductDetail[_ProductId].price*AmountNft;

//      IERC20(PaymentTokens).transfer(_to, TotalPrice);
//      IERC20(PaymentTokens).transfer(_to, TotalPrice);
    
//      }
// }


// //TotalPrice=ProductDetail[_ProductId].price*ProductDetail[_ProductId].Amount;
