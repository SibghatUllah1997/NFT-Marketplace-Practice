require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');

const privatekey1="3de12ab1e199cd2b0b6a5ff528de1415debb0cfc0b921e5d2b5a78f972fc5785"

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "goerli",
  networks: {
    hardhat: {
    },
    goerli: {
       
      url: "https://rpc.ankr.com/eth_goerli",
      accounts: [privatekey1]
    },
    BSCscan: {
       
      url: "https://rpc.ankr.com/bsc",
      accounts: [privatekey1]
    },
    Sepolia: {
       
      url: "https://rpc.sepolia.org",
      accounts: [privatekey1]
    }
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 40000
  },
  etherscan: {
    apiKey: "RJ61S4CVJ776QS721JNDPMKXXE6FN9RYIM",
  },
  
};
// /** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: "0.8.17",
// };

