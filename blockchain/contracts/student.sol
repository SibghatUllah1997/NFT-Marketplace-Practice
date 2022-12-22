// SPDX-License-Identifier:MIT

pragma solidity >0.7.0;
contract innocent{
    string name;
    uint age;
    uint height;
    
    string public result;
    function getzainnumber(string memory _name ,uint _age, uint _height,string memory _result )external{
        name = _name;
        age = _age;
        height =_height;
        result = _result;

    }
}