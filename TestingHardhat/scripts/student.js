const hre = require("hardhat");

async function main() {

const name = "ali";
const rollNo = 2;
const marks = 10;

const currentTimestampInSeconds = Math.round(Date.now() / 1000);
const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

const lockedAmount = hre.ethers.utils.parseEther("1");

  const school = await hre.ethers.getContractFactory("student");
  const schoolDeploy = await school.deploy(  name, rollNo,  marks );

  await schoolDeploy.deployed();

  console.log(
    `Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${school.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
