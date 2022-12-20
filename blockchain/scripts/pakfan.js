const hre = require("hardhat");

async function main() {
  const name = "Hp";
  const pieces = 10;
  const price = 100;
 
  const jaddu= await hre.ethers.getContractFactory("dell");
  const jaddudeploy = await jaddu.deploy(name, pieces , price);

  await jaddudeploy.deployed;
 

  
  console.log(
    `my Cars contract deployed to ${jaddudeploy.address}`
 );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
