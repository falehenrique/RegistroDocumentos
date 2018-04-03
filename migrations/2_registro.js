var RegistroDocumento = artifacts.require("./RegistroDocumento.sol");

module.exports = function(deployer) {
  deployer.deploy(RegistroDocumento);
};
