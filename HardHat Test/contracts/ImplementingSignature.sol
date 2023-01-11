// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

// game developer depoloys contract
contract gameRewards is Ownable {
    // game developer's account
    address public _owner = 0x64ddB6c1D4dFa10042d02a08bD1373412F9d4b17;
    /* secret key that will only be given to those who owner will approve
    this key will be the hashed & converted into signature 
    which will be splited to enter as parameters in next functions
    */
    string key =
        "0x8be241d1a693e9dd3f3d9a3f2ea78ce24d644d0e804d683beb2decf63a251b3f134eed2281dc518b19d93cdd810865c34bbcf9878e55e6342bcf0d90ea8d7df11c";

    mapping(address => bool) public isAllowlistAddress;

    function addPlayer(address buyer) public onlyOwner returns (string memory) {
        //address _address= buyer;
        isAllowlistAddress[buyer] = true;
        return key;
    }

    // player claims price
    function claimPrize(
        bytes32 _hashedMessage,
        uint8 _v,
        bytes32 _r,
        bytes32 _s
    ) public view returns (bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHashMessage = keccak256(
            abi.encodePacked(prefix, _hashedMessage)
        );
        address signer = ecrecover(prefixedHashMessage, _v, _r, _s);

        require(
            isAllowlistAddress[signer] == true,
            "you are not the approved player"
        );

        // if the signature is signed by the owner
        if (signer == _owner) {
            // give player (msg.sender) a prize
            return true;
        }
        return false;
    }
}
