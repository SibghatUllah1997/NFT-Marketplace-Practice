const { ethers } = require("hardhat");
const hre = require("hardhat");
async function main() {
 
  const ERC= await hre.ethers.getContractFactory("kablitoken");
  const ERCdeploy = await ERC.deploy("100000000");

  await ERCdeploy.deployed();

  let[owner,addr1] = await ethers.getSigners(); 
  console.log("address of owner",owner.address,":",addr1);

   await ERCdeploy.transfer(addr1.address,100);
    let checkbalance = await ERCdeploy.balanceOf(addr1.address);
   
  console.log("check",checkbalance);

  let checkbalance1 = await ERCdeploy.balanceOf(owner.address);

  console.log("check",checkbalance1);


 

  
  console.log(
    `my Cars contract deployed to ${ERCdeploy.address}`
 );

  }
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
