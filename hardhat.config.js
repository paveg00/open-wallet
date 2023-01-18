/** @type import('hardhat/config').HardhatUserConfig */


// import('hardhat/config').HardhatUserConfig


require("dotenv").config();
// require("@nomiclabs/hardhat-ganache");
require("@nomiclabs/hardhat-waffle");

module.exports = {
  // defaultNetwork: "ganache",
  // networks: {
  //   ganache: {
  //     url: 'http://127.0.0.1:8585',
  //     gasLimit: 6000000000,
  //     defaultBalanceEther: 10,
  //   },
  // },
  solidity: "0.8.0",
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
};
