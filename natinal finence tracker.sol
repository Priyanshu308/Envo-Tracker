// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ClimateFundTracker {
    address public government;
    mapping(address => uint256) public allocatedFunds;
    mapping(address => bool) public isRegistered;
    uint256 public totalFunds;

    event FundsAllocated(address indexed recipient, uint256 amount);
    event FundClaimed(address indexed recipient, uint256 amount);

    modifier onlyGovernment() {
        require(msg.sender == government, "Not authorized");
        _;
    }

    modifier onlyRegistered() {
        require(isRegistered[msg.sender], "Not a registered recipient");
        _;
    }

    constructor() {
        government = msg.sender;
    }

    function registerRecipient(address recipient) external onlyGovernment {
        require(!isRegistered[recipient], "Recipient already registered");
        isRegistered[recipient] = true;
    }

    function allocateFunds(address recipient, uint256 amount) external onlyGovernment {
        require(isRegistered[recipient], "Recipient not registered");
        require(amount > 0, "Amount must be greater than 0");

        allocatedFunds[recipient] += amount;
        totalFunds += amount;

        emit FundsAllocated(recipient, amount);
    }

    function claimFunds(uint256 amount) external onlyRegistered {
        require(amount > 0 && amount <= allocatedFunds[msg.sender], "Invalid claim amount");

        allocatedFunds[msg.sender] -= amount;
        totalFunds -= amount;

        

        emit FundClaimed(msg.sender, amount);
    }
}
