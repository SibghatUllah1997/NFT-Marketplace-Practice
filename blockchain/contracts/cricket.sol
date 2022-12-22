//SPDX-License-Identifier:MIT
pragma solidity >0.7.4;

contract Satisfied{
    string  public name;
    string  password;

    function info(string memory _name,string memory _password)public{
        name=_name;
        password=_password;
        if (keccak256(abi.encodePacked(password))==keccak256(abi.encodePacked("welcome"))){
            password="welcome";
        }
        else 
            password="reverse";
    }

    function getpasscode() public view returns (string memory){
            return password;
    }
   
 
}