# FundMe - Ethereum Sepolia Crowdfunding Smart Contract

A simple Ethereum-based crowdfunding smart contract that allows users to send ETH and automatically converts the value to USD using Chainlink Price Feeds.

## Features

- Users can fund the contract with ETH (minimum $5 USD)
- Automatic ETH to USD conversion using Chainlink Price Feeds
- Only the contract owner can withdraw funds
- Fallback and receive functions for direct ETH transfers
- Tracks all funders and their contributions

## Technical Details

- Built with Solidity ^0.8.4
- Uses Chainlink Price Feeds for ETH/USD conversion
- Implements security best practices:
  - Only owner can withdraw funds
  - Minimum funding amount requirement
  - Safe withdrawal pattern
  - Immutable owner address

## Contract Functions

- `fund()`: Allows users to send ETH to the contract (minimum $5 USD)
- `withdraw()`: Allows the owner to withdraw all funds
- `getVersion()`: Returns the version of the Chainlink Price Feed contract
- `fallback()` and `receive()`: Handle direct ETH transfers

## Getting Started

1. Go to [Remix IDE](https://remix.ethereum.org/)
2. Create two new files:
   - `FundMe.sol`
   - `PriceConverter.sol`
3. Copy the code from this repository into the respective files
4. In the Solidity Compiler tab:
   - Select compiler version 0.8.4
   - Click "Compile"
5. In the Deploy & Run Transactions tab:
   - Select "Injected Provider - MetaMask" as the environment
   - Select the FundMe contract
   - Click "Deploy"
