// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.7.0;
contract PUPIL{
string name;
uint rollno;
uint marks;
string public result;
function studentinfo(string memory Name,uint _rn,uint _marks) public {

    name = Name;
    rollno = _rn;
    marks = _marks;
    if(marks>=50){
        result = "pass";

    }

    
    else 
    result = "fail";

}


}

