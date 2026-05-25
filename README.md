## Foundry

# 💰 Foundry FundMe

A minimal and secure crowdfunding smart contract built using Solidity and Foundry, allowing users to fund ETH with a minimum USD value enforced via price feeds.

---

## 📌 Overview

FundMe is a smart contract that enables users to send ETH to the contract while ensuring a minimum contribution value in USD using decentralized price feeds.

The contract owner can withdraw all funds, and multiple contributors are tracked efficiently.

---

## 🚀 Features

- ✅ Minimum funding amount enforced in USD  
- ✅ Integration with price feeds (e.g., Chainlink)  
- ✅ Tracks all funders  
- ✅ Owner-only withdrawal  
- ✅ Gas-optimized withdrawal logic  
- ✅ Full unit & integration testing  
- ✅ Scripted deployment & interaction  

---

## 🧱 Tech Stack

- Solidity ^0.8.x  
- Foundry (Forge, Cast, Anvil)  
- Chainlink Price Feeds  
- Git & GitHub  

---

## 📂 Project Structure
foundry-fundme/
├── src/
│ └── FundMe.sol
├── script/
│ ├── DeployFundMe.s.sol
│ ├── FundFundMe.s.sol
│ └── WithdrawFundMe.s.sol
├── test/
│ ├── FundMeTest.t.sol
│ └── Integration/
│ └── Interaction.t.sol
├── lib/
├── foundry.toml
└── README.md

---

## ⚙️ How It Works

1. Users call `fund()` and send ETH  
2. ETH value is converted to USD using a price feed  
3. Transaction is accepted only if it meets the minimum threshold  
4. Funders are recorded in a mapping  
5. Owner can call `withdraw()` to collect all funds  

---

## 🧪 Testing

This project includes comprehensive tests using Foundry:

- ✅ Unit tests for core logic  
- ✅ Integration tests for scripts  
- ✅ Multiple funders scenario  
- ✅ Withdrawal edge cases  

### Run Tests

bash
forge test
forge test -vvv

---

##🚀 Deployment
Start Local Node
anvil

Deploy Contract
forge script script/DeployFundMe.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast

---

##🔁 Interacting with Contract
Fund Contract
forge script script/FundFundMe.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast

Withdraw Funds
forge script script/WithdrawFundMe.s.sol --rpc-url <RPC_URL> --private-key <PRIVATE_KEY> --broadcast

---

##🔐 Environment Variables

Create a .env file:

PRIVATE_KEY=your_private_key
RPC_URL=your_rpc_url

---

##📊 Gas Optimization
Uses memory caching for funders
Minimizes storage reads/writes
Efficient withdrawal pattern

---

##⚠️ Security Notes
Only owner can withdraw funds
Price feed dependency must be correct per network
Not audited — for educational purposes

---

##🛣️ Future Improvements
🔹 Add frontend (React + Ethers.js)
🔹 Support multiple tokens (ERC20 funding)
🔹 Add events & indexing for analytics
🔹 Upgradeable contract support

---

##🙌 Acknowledgements

Inspired by Web3 development practices
Built using Foundry toolkit

---

##📄 License

MIT License







