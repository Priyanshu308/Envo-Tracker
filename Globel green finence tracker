// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GlobalGreenFinanceTracker {

    address public owner;
    
    // represent a financial transaction
    struct Transaction {
        address sender;      
        address receiver;    
        uint256 amount;      
        uint256 timestamp;   
    }

    //  store  transactions
    Transaction[] public transactions;

    // Mapping to store the total aid received by each developing nation
    mapping(address => uint256) public aidReceived;

    // Events to log important actions
    event TransactionRecorded(address indexed sender, address indexed receiver, uint256 amount, uint256 timestamp);
    event AidReceived(address indexed receiver, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Function to record a financial transaction
    function recordTransaction(address _receiver, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        transactions.push(Transaction(msg.sender, _receiver, _amount, block.timestamp));
        emit TransactionRecorded(msg.sender, _receiver, _amount, block.timestamp);
    }

    // Function to track the flow of aid to developing nations
    function trackAidFlow() external {
        uint256 totalAid = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            Transaction memory transaction = transactions[i];
            totalAid += transaction.amount;
            aidReceived[transaction.receiver] += transaction.amount;
        }
        emit AidReceived(address(this), totalAid);
    }

    // Function to get the total aid received by a specific developing nation
    function getAidReceived(address _receiver) external view returns (uint256) {
        return aidReceived[_receiver];
    }

    // Function to withdraw contract balance 
    function withdrawBalance() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
