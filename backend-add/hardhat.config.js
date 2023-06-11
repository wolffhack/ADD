require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-deploy");
require("hardhat-gas-reporter");
require("solidity-coverage");
require("hardhat-contract-sizer");
require("@openzeppelin/hardhat-upgrades");
require("hardhat-deploy-ethers")
require("./tasks");
// require('dotenv').config();
require("@chainlink/env-enc").config();

const SOLC_SETTINGS = {
  optimizer: {
    enabled: true,
    runs: 1_000,
    details: { yul: false },
  },
};

module.exports = {
  etherscan: {
    apiKey: {
      // fvm: process.env.FILLFOX_API_KEY,
    },
  },

  solidity: {
    compilers: [
      {
        version: "0.8.17",
        settings: SOLC_SETTINGS,
      },
      {
        version: "0.8.1",
        settings: SOLC_SETTINGS,
      },
      {
        version: "0.8.9",
        settings: SOLC_SETTINGS,
      },
      {
        version: "0.8.11",
        settings: SOLC_SETTINGS,
      },
    ],
  },

  defaultNetwork: "Calibration",

  networks: {
    Calibration: {
      chainId: 314159,
      url: "https://api.calibration.node.glif.io/rpc/v1",
      accounts: [PRIVATE_KEY],
    },
    FilecoinMainnet: {
      chainId: 314,
      url: "https://api.node.glif.io",
      accounts: [PRIVATE_KEY],
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};
