//SPDX-License-Identifier:MIT
pragma solidity >0.7.0;

contract Hotel{

    string  public OwnerName = "Sanwal";
    string public HotelName = "Sanwal hotel";
    uint public  ContactNo = 306000000000;
    string public hoteladdress = "canal view ";

    struct Menu{
        string name;

    }
    Menu public items;
    uint public prize;

    function getinfo(string memory _ITEMS)public{
        items.name =_ITEMS;
    if(keccak256(abi.encodePacked(_ITEMS))==keccak256(abi.encodePacked("Biryani"))){
        prize=100;
    }
    else if (keccak256(abi.encodePacked(_ITEMS))==keccak256(abi.encodePacked("Daal Chawal"))){
        prize=150;
    }
    }
    struct Carparking{
     
     string Name;
    
    }
    Carparking public place;
    uint public tprize;
    function byticket(string memory _TName)public{
        place.Name= _TName;
        if (keccak256(abi.encodePacked(_TName))==keccak256(abi.encodePacked("GLI"))){
        tprize=20;
    }
      else if (keccak256(abi.encodePacked(_TName))==keccak256(abi.encodePacked("civic"))){
        tprize=30;

    }
     else if (keccak256(abi.encodePacked(_TName))==keccak256(abi.encodePacked("sportage"))){
        tprize=20;
}
    }
}