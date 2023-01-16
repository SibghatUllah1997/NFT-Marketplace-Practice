const { ethers, upgrades,  run  } = require("hardhat");

async function main() {
  const UpgradeableNFTMintingListing = await hre.ethers.getContractFactory("UpgradeableNFTMintingListing");
  const proxy = await upgrades.deployProxy(UpgradeableNFTMintingListing,  []);
    // initializer: 'initialize' ,;    // {unsafeAllowCustomTypes:true}

  await proxy.deployed();
  console.log(proxy.address);

//   await run(`verify:verify`, {
//     address: proxy.address,
//     constructorArguments: [proxy],
//   });
}

  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });