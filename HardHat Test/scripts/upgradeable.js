const { ethers, upgrades,  run  } = require("hardhat");

async function main() {
  const Upgradeable1155 = await ethers.getContractFactory("UpgradeableNFTMintingListing");
  const proxy = await upgrades.deployProxy(Upgradeable1155, [12, 12]);

  await proxy.deployed();
  console.log(proxy.address);

  await run(`verify:verify`, {
    address: priceFeedConsumer.address,
    constructorArguments: [priceFeedAddress],
  });
}

  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });