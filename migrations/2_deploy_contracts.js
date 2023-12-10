var RescueAgentsContract = artifacts.require("RescueAgentsContract");
var FishersContract = artifacts.require("FishersContract");
var MarineOfficeContract = artifacts.require("MarineOfficeContract");

module.exports = function(deployer) {
  deployer.deploy(RescueAgentsContract);
  deployer.deploy(FishersContract);
  deployer.deploy(MarineOfficeContract);
};