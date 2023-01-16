const Web3 = require('web3');
const web3 = new Web3();

//async function main() {
web3.eth.personal.sign(
    web3.utils.utf8ToHex("0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"), // convert the message to hex
    "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", // address of account
    "25d379f64f01bbd3554f1362f59dd8882d11c0299104a338466640d35ed7eda3", // password if necessary 
    (err, signature) => { 
        // handle the error or use the signature
        console.log(signature);
    }
)

