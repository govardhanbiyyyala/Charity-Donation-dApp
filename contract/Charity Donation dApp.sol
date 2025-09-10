
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Charity Donation dApp
 * @dev A simple decentralized application for transparent donations
 */
contract Project {
    address public owner;
    uint256 public totalDonations;

    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }

    Donation[] public donations;

    event Donated(address indexed donor, uint256 amount, uint256 timestamp);
    event Withdrawn(address indexed owner, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Donate ETH to the charity
     */
    function donate() external payable {
        require(msg.value > 0, "Must send ETH to donate");

        donations.push(Donation({
            donor: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp
        }));

        totalDonations += msg.value;

        emit Donated(msg.sender, msg.value, block.timestamp);
    }

    /**
     * @dev Get details of a donation
     */
    function getDonation(uint256 index) external view returns (address, uint256, uint256) {
        require(index < donations.length, "Invalid index");
        Donation memory d = donations[index];
        return (d.donor, d.amount, d.timestamp);
    }

    /**
     * @dev Withdraw all collected funds (only owner)
     */
    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available");
        payable(owner).transfer(balance);

        emit Withdrawn(owner, balance);
    }
}
##contract
"C:\Users\Dell\OneDrive\Desktop\Pictures\Screenshots\Screenshot 2025-09-10 143440.png"
