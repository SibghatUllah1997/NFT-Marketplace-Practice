const hre = require("hardhat");

async function main() {
  

  
  const panadol= await hre.ethers.getContractFactory("satisfied");
  const panadoldeploy = await panadol.deploy();

  await panadoldeploy.deployed();
 

  
  console.log(
    `my Cars contract deployed to ${panadoldeploy.address}`
 );
 return panadoldeploy;
  }


 async function set(pdep){
 const abc = await pdep .info(name,password);
 console.log ("my  abc function is deployed ",abc);

 }
 async function call(){
    const pdep = await main ();
    console. log ("my  contracts deployed run",pdep);
    await set (pdep);
 }

 async function get(pdep){
    const Pd = await pdep.getpasscode();
    console.log("get function",Pd);
 }
    function setValues(value){
        return value;
    }
    let name = setValues("sanwal");
    let password =setValues("welcome");
    console.log("passcode",name,password);

  call().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });

  