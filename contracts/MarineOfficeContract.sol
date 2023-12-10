// SPDX-License-Identifier: MIT
pragma solidity 0.5.16;

contract MarineOfficeContract {
    address public marineOffice;

    struct DataCapture {
        uint256 timestamp;
        string gpsLocation;
        uint256 humidity;
        uint256 salinity;
        uint256 pH;
        uint256 oxygenLevel;
        uint256 chlorophyll;
        bool fishExistence;
        bool emergencyAlert;
        string emergencyMessage;
    }

    mapping(address => DataCapture[]) public fishermanData;

    event DataCaptured(
        address indexed fisherman,
        uint256 indexed timestamp,
        string gpsLocation
    );

    event EmergencyAlertSent(
        address indexed rescueAgent,
        address indexed sender,
        string emergencyMessage
    );

    constructor() public {
        marineOffice = msg.sender;
    }

    modifier onlyMarineOffice() {
        require(msg.sender == marineOffice, "Only Marine Office can call this function");
        _;
    }

    function captureData(
        address fisherman,
        string calldata gpsLocation,
        uint256 humidity,
        uint256 salinity,
        uint256 pH,
        uint256 oxygenLevel,
        uint256 chlorophyll,
        bool fishExistence,
        bool emergencyAlert,
        string calldata emergencyMessage
    ) external onlyMarineOffice {
        DataCapture memory newData = DataCapture(
            block.timestamp,
            gpsLocation,
            humidity,
            salinity,
            pH,
            oxygenLevel,
            chlorophyll,
            fishExistence,
            emergencyAlert,
            emergencyMessage
        );
        fishermanData[fisherman].push(newData);

        emit DataCaptured(
            fisherman,
            newData.timestamp,
            gpsLocation
        );

        if (emergencyAlert) {
            // Envoyer une alerte d'urgence aux Agents de secours
            emit EmergencyAlertSent(msg.sender, fisherman, emergencyMessage);
        }
    }
}