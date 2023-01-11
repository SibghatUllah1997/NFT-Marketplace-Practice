var Web3 = require('web3');
var web3 = new Web3();
var message = "yo syed Muhammad Abdullah here!";

console.log("version :", web3.version);

var signature = web3.eth.accounts.sign(message, '3de12ab1e199cd2b0b6a5ff528de1415debb0cfc0b921e5d2b5a78f972fc5785');

console.log("signature :", signature);

var messageHash= web3.eth.accounts.hashMessage(message);
// recover 1
var recover_1 = web3.eth.accounts.recover({
    messageHash: messageHash,
    v: signature.v,
    r: signature.r,
    s: signature.s
});

console.log("recover 1 :", recover_1);


// message, signature
var recover_2 = web3.eth.accounts.recover(message, signature.signature);
console.log("recover 2 :", recover_2);

// message, v, r, s
var recover_3 = web3.eth.accounts.recover(message, signature.v, signature.r, signature.s);
console.log("recover 3 :", recover_3);