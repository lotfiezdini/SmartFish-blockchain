// SPDX-License-Identifier: MIT
pragma solidity 0.5.16;

contract RescueAgentsContract {
    address public marineOffice;
    mapping(address => bool) public isRescueAgent;

    struct Alert {
        address sender;
        string emergencyMessage;
    }

    mapping(address => Alert[]) public rescueAgentAlerts;

    event EmergencyAlertReceived(
        address indexed rescueAgent,
        address indexed sender,
        string emergencyMessage
    );

    constructor  () public {
        marineOffice = msg.sender;
    }

    modifier onlyMarineOffice() {
        require(msg.sender == marineOffice, "Only Marine Office can call this function");
        _;
    }

    modifier onlyRescueAgent() {
        require(isRescueAgent[msg.sender], "Only registered Rescue Agents can call this function");
        _;
    }

    function registerAsRescueAgent() external {
        isRescueAgent[msg.sender] = true;
    }

    function receiveEmergencyAlert(address sender, string calldata emergencyMessage) external onlyRescueAgent {
        Alert memory newAlert = Alert(sender, emergencyMessage);
        rescueAgentAlerts[msg.sender].push(newAlert);

        emit EmergencyAlertReceived(
            msg.sender,
            sender,
            emergencyMessage
        );
    }
}