//const hre = require("hardhat");

async function main() {

 
  const youtube= await hre.ethers.getContractFactory("Students");
  const youtubedeploy = await youtube.deploy();

  await youtubedeploy.deployed();
 

  
  console.log(
   `my Cars contract deployed to ${youtubedeploy.address}`
);
return youtubedeploy;
 }
 async function set(ydep){
  let xyz=await ydep.Info("sanwal",7,78);
 console.log ("my  xyz  function is deployed",xyz);
}
 async function call(){
    let ydep =  await main();
    console.log(ydep);
   await set(ydep);
    
 }
 call();
