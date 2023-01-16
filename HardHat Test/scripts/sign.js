// const signTest = async function(){

//     // Using eth.sign()

//     let accounts = await web3.eth.getAccounts();
//     let msg = "Some data"
//     let prefix = "\x19Ethereum Signed Message:\n" + msg.length
//     let msgHash1 = web3.utils.sha3(prefix+msg)
//     let sig1 = await web3.eth.sign(msg, accounts[0]);

//     // Using eth.accounts.sign() - returns an object

//     let privateKey = "25d379f64f01bbd3554f1362f59dd8882d11c0299104a338466640d35ed7eda3"
//     let sigObj = await web3.eth.accounts.sign(msg, privateKey)

//first

// const { signMessage } = require ("@hardhat/web3");

// async function main() {
//   const message = "Hello, world!";
//   const privateKey = "25d379f64f01bbd3554f1362f59dd8882d11c0299104a338466640d35ed7eda3"; // Replace with your private key

//   const signedMessage = await signMessage(message, privateKey);
//   console.log(signedMessage);
// }
// main();

//second
// const Web3 = require("web3");

// async function main() {
//   const web3 = new Web3("http://127.0.0.1:8545/"); // Replace with your Ethereum node URL
//   const message = "Hello, world!";
//   const privateKey = "25d379f64f01bbd3554f1362f59dd8882d11c0299104a338466640d35ed7eda3"; // Replace with your private key
//   const address = web3.eth.accounts.privateKeyToAccount(privateKey).address;

//   const signedMessage = await web3.eth.personal.sign(message, address); 
//   console.log(signedMessage);
// }

// main();





