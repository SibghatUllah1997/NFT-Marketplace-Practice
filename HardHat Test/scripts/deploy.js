

async function main() {
  // We get the contract to deploy
  const USDRewards = await ethers.getContractFactory("USDRewards");
  console.log("Deploying Contract . . . . ");
  const usdrewards = await USDRewards.deploy();

  await usdrewards.deployed();
  console.log(`ERC20supply Contract deployed to: ${USDRewards.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
