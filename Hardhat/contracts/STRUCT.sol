//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract book{
    string bookName;
    string Author;
    string Published = "Aug";
    function info(string memory Name)public{
        bookName=Name;
      
    }
     function getname(string memory Auth)public{
        
        Author=Auth;
    }
     function info()public view returns(string memory){
        return bookName;
        
    }
    function setname()public view returns(string memory){
        
        return Author;
    }
} 