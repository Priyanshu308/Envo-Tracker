// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarbonEmissionTracker {
    address public admin;
    mapping(string => uint256) public countryEmissions;

    event EmissionRecorded(string indexed country, uint256 emissions);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function recordEmission(string memory country, uint256 emissions) external onlyAdmin {
        require(emissions >= 0, "Emissions must be non-negative");

        // Update  and add the emissions on  country level
        countryEmissions[country] = emissions;

        emit EmissionRecorded(country, emissions);
    }

    function getEmission(string memory country) external view returns (uint256) {
        return countryEmissions[country];
    }
}
