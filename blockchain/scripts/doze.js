const hre = require("hardhat");

async function main() {
  const company = "stylo";
  const salary = 10000;

 
  const style= await hre.ethers.getContractFactory("hub");
  const styledeploy = await style.deploy(company,salary);

  await styledeploy.deployed();
 

  
  console.log(
    `my Cars contract deployed to ${styledeploy.address}`
 );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
