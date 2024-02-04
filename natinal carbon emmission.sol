// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarbonEmissionTracker {
    address public government;
    mapping(address => uint256) public declaredEmissions;
    mapping(address => uint256) public actualEmissions;

    event EmissionDeclared(address indexed industry, uint256 amount);
    event EmissionRecorded(address indexed industry, uint256 amount);

    modifier onlyGovernment() {
        require(msg.sender == government, "Not authorized");
        _;
    }

    constructor() {
        government = msg.sender;
    }

    function declareEmissions(uint256 amount) external {
        declaredEmissions[msg.sender] = amount;

        emit EmissionDeclared(msg.sender, amount);
    }

    function recordActualEmissions(address industry, uint256 amount) external onlyGovernment {
        actualEmissions[industry] = amount;

        emit EmissionRecorded(industry, amount);
    }

    function compareEmissions() external view returns (bool) {
        require(declaredEmissions[msg.sender] > 0, "No declaration made");

        // Compare declared emissions with actual emissions
        return actualEmissions[msg.sender] <= declaredEmissions[msg.sender];
    }
}
