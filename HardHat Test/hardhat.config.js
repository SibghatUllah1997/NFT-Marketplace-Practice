require("@nomicfoundation/hardhat-toolbox");
require('@openzeppelin/hardhat-upgrades');

const privatekey1="25d379f64f01bbd3554f1362f59dd8882d11c0299104a338466640d35ed7eda3"

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
    apiKey: "6NX14RTHTYPG9W3ZEIKCUQ9QS1YBM75K5U", // Your Etherscan API key
  },
};

