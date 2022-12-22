const hre = require("hardhat");

async function main() {
  const name = "ali";
  const rollno = 34;
  const marks=99;

 
  const fifa= await hre.ethers.getContractFactory("jeko");
  const fifadeploy = await fifa.deploy(name,rollno,marks);

  await fifadeploy.deployed();
 

  
  console.log(
    `my Cars contract deployed to ${fifadeploy.address}`
 );
}
main();

