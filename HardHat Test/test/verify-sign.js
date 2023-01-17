// const {
//   time,
//   loadFixture,
// } = require("@nomicfoundation/hardhat-network-helpers");
// const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
// const { expect } = require("chai");


//   describe("SignnVerify", function () {
//     it("Check Signature", async function () {
//     const accounts = await ethers.getSigners(2)  //await web3.eth.getAccounts();
//     const SignnVerify = await ethers.getContractFactory("SignnVerify");
//     const contract = await SignnVerify.deploy();
//     await contract.deployed();

//     const signer = accounts[0]
//     const to = accounts[1].address
//     const amount = 999
//     const message = "Hello World" 
//     const nonce = 123
//     const privateKey = ""
    

//     const sigObj = await web3.eth.accounts.sign(msg, privateKey)
//     const hash = await contract.getMessageHash(to, amount, message, nonce)
//     const sig = await contract.signMessage(ethers.utils.arrayify(hash))


//     // let prefix = "\x19Ethereum Signed Message:\n" + msg.length
//     // let msgHash1 = web3.utils.sha3(prefix+msg)

//     // let sig1 = await web3.eth.sign(msg, accounts[0]);


//     expect(await contract.verify(signer.address, to, amount, message, nonce, sig)).to.expect(true)
//     expect(await contract.verify(signer.address, to, amount+1, message, nonce, sig)).to.expect(false)
//     });

// });



