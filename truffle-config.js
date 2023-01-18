module.exports = {
  networks: {
    loc_development_development: {
      network_id: "*",
      port: 8545,
      host: "127.0.0.1"
    },
    loc_dev1_dev1: {
      network_id: "*",
      port: 7575,
      host: "127.0.0.1"
    }
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.0"
    }
  }
};
