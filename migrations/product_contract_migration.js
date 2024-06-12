const ProductAuthentication = artifacts.require("ProductAuthentication");

module.exports = function (deployer) {
  deployer.deploy(ProductAuthentication);
};
