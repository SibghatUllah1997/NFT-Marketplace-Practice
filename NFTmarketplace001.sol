//SPDX-License-Identifier:MIT
pragma solidity <0.8.12;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ERC1155, Ownable {
    IERC20 paymenttoken;
    string public baseURI;
    constructor(string memory _URI) ERC1155("") { 
        baseURI = _URI;
    }
    
    function updateURI(string memory uri) public {
        baseURI = uri;
    }
    struct Nft {
        string name;
        string description;
        uint256 price;
        uint256 amount;
        address owner;
    }
    mapping(uint256 => Nft) NFTS;

    uint256 public totalnfts;
    uint [] public listArray;

    function mintNFT(
        string memory _name,
        string memory _desc,
        uint256 _price,
        uint256 _amount,
        address payable _owner
    ) public onlyOwner {
        require(_price > 0, "price must be greater than zero");
        NFTS[totalnfts] = Nft(_name, _desc, _price, _amount, _owner);
      
        totalnfts++;
    }

    function listNFT(uint256 Tokenid, uint256 price) public {
        require(NFTS[Tokenid].price != 0, "is not equal to zero");
        require(balanceOf(msg.sender, Tokenid) > price, "");
        listArray.push(Tokenid);
    }

    function buyNft(uint256 tokenid, uint256 _amount) public payable {
        require (_amount <=NFTS[tokenid].amount,"");

        safeTransferFrom(NFTS[tokenid].owner, msg.sender, tokenid,_amount, "");

        uint256 amountPayable =_amount * NFTS[tokenid].price;
        require(msg.value >= amountPayable, "Please send enough funds");

        IERC20(paymenttoken).transfer(NFTS[tokenid].owner, amountPayable);
     }
      }
