# Fund-Me
My first Solidity project! This FundMe smart contract demonstrates key concepts like modifiers, libraries, and Chainlink Price Feeds for real-time ETH/USD conversion. It implements a decentralized funding mechanism and marks the start of my blockchain development journey.

# FundMe Smart Contract

This project is a Solidity smart contract that allows users to fund a project using ETH. It leverages Chainlink Price Feeds to convert ETH contributions into USD values and ensures that only the contract owner can withdraw the funds.

## Features
- **Minimum Funding Requirement**: Users must contribute at least $2 (in ETH).
- **Chainlink Price Feeds**: Real-time ETH/USD price conversion using Chainlink's data feed.
- **Secure Withdrawals**: Only the contract owner can withdraw the accumulated funds.
- **Efficient Design**: Uses libraries (`PriceConverter`) and custom errors (`NotOwner`) for gas optimization.

## Contract Details
### Main Contract: `FundMe.sol`
- Tracks contributions of each funder.
- Enforces a minimum funding threshold.
- Allows only the contract owner to withdraw the funds.

### Library: `PriceConverter.sol`
- Provides utility functions for fetching the ETH/USD price and converting ETH amounts into USD.

## Prerequisites
- **Solidity Version**: 0.8.24
- **Chainlink Price Feed Address**: Sepolia ETH/USD (`0x694AA1769357215DE4FAC081bf1f309aDC325306`)

## How It Works
1. Deploy the `FundMe` contract.
2. Users can call the `fund` function to send ETH. The contract ensures the amount is at least $2.
3. The contract owner can withdraw all funds using the `withdraw` function.

## Deployment
The contract is deployed on the **Sepolia testnet**. Ensure you have a test wallet with ETH and access to a blockchain development environment like Hardhat or Remix.

## Code Overview
### Constructor
Sets the deployer as the owner of the contract:
```solidity
constructor() {
    i_owner = msg.sender;
}

