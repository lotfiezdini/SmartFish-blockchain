// SPDX-License-Identifier: MIT
pragma solidity 0.5.16;

contract FishersContract {
    address public marineOffice;
    mapping(address => bool) public isFisherman;

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

    event EmergencyAlert(
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

    modifier onlyFisherman() {
        require(isFisherman[msg.sender], "Only registered Fishermen can call this function");
        _;
    }

    function registerAsFisherman() external {
        isFisherman[msg.sender] = true;
    }

    function captureData(
        string calldata gpsLocation,
        uint256 humidity,
        uint256 salinity,
        uint256 pH,
        uint256 oxygenLevel,
        uint256 chlorophyll,
        bool fishExistence
    ) external onlyFisherman {
        DataCapture memory newData = DataCapture(
            block.timestamp,
            gpsLocation,
            humidity,
            salinity,
            pH,
            oxygenLevel,
            chlorophyll,
            fishExistence,
            false,
            ""
        );
        fishermanData[msg.sender].push(newData);

        emit DataCaptured(
            msg.sender,
            newData.timestamp,
            gpsLocation
        );
    }

    function sendEmergencyAlert(string calldata message) external onlyMarineOffice {
        for (uint256 i = 0; i < fishermanData[msg.sender].length; i++) {
            if (fishermanData[msg.sender][i].fishExistence) {
                fishermanData[msg.sender][i].emergencyAlert = true;
                fishermanData[msg.sender][i].emergencyMessage = message;
            }
        }

        emit EmergencyAlert(msg.sender, message);
    }
}