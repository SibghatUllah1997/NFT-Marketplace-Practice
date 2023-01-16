

async function main() {
  // We get the contract to deploy
  const SIGNVerify = await ethers.getContractFactory("SIGNVerify");
  console.log("Deploying Contract . . . . ");
  const signVerify = await SIGNVerify.deploy();

  await signVerify.deployed();
  console.log(`ERC20supply Contract deployed to: ${SIGNVerify.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
