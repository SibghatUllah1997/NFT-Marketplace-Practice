const Web3 = require('web3');
const web3 = new Web3();

const message = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4";
`   `
console.log("version :", web3.version);

const signature = web3.eth.accounts.sign(message, '25d379f64f01bbd3554f1362f59dd8882d11c0299104a338466640d35ed7eda3');

console.log("signature :", signature);

const messageHash= web3.eth.accounts.hashMessage(message);
// recover 1
const recover_1 = web3.eth.accounts.recover({
    messageHash: messageHash,
    v: signature.v,
    r: signature.r,
    s: signature.s
});

console.log("recover 1 :", recover_1);

// message, signature
const recover_2 = web3.eth.accounts.recover(message, signature.signature);
console.log("recover 2 :", recover_2);

// message, v, r, s
const recover_3 = web3.eth.accounts.recover(message, signature.v, signature.r, signature.s);
console.log("recover 3 :", recover_3);

