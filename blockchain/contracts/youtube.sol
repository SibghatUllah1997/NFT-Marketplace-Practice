// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.7.0;
contract Students{
    string public name;
    uint public  rollno;
    uint public marks;
    
    
    string public result;
    function Info(string memory _name, uint _rollno,uint _marks) public{
        name= _name;
        rollno = _rollno;
        marks =_marks;
          if(_marks>50){
              result = "pass";
          }
          else 
          result = "fail";
            
        }
    }
