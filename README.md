## Foundry

# 💰 FundMe Smart Contract (Foundry)

A production-inspired crowdfunding smart contract built with Solidity + Foundry, enabling users to fund ETH with a minimum USD value using Chainlink price feeds.

Designed with multi-network support, full testing, and deployment scripts — following real-world Web3 development practices.

---

## 📌 About the Project

FundMe allows users to send ETH while ensuring a minimum contribution of $5 USD using live price data.

This project demonstrates:

- 🔹 Smart contract funding logic
- 🔹 Integration with Chainlink Price Feeds
- 🔹 Multi-network deployment (Local + Testnet + Mainnet)
- 🔹 Secure withdrawal patterns
- 🔹 Full testing using Foundry

---

## ⚙️ Features
- 💸 Fund contract with ETH
- 💲 Minimum $5 USD enforced (MINIMUM_USD)
- 🔗 Chainlink price feed integration
- 👥 Tracks multiple funders
- 🔐 Owner-only withdrawal
- ⚡ Gas-optimized withdrawal (cheaperWithdraw)
- 🧪 Unit + Integration tests
- 🚀 Script-based deployment & interaction

---

## 🧱 Tech Stack

- Solidity ^0.8.18
- Foundry (Forge, Anvil)
- Chainlink Price Feeds
- EVM (Ethereum Virtual Machine)
- Git & GitHub

---

## 📂 Project Structure
```
foundry-fundme/
├── src/
│   ├── FundME.sol
│   └── PriceConverter.sol
├── script/
│   ├── DeployFundMe.s.sol
│   ├── HelperConfig.s.sol
│   └── Interaction.s.sol
├── test/
│   ├── FundMeTest.t.sol
│   ├── Interaction.t.sol
│   └── Mocks/
│       └── MockV3Aggregator.sol
├── lib/
├── foundry.toml
```
---

## 🌐 Network Configuration (🔥 Highlight)

This project uses a HelperConfig system to dynamically manage different networks.

---

## 🧠 Smart Logic
```
if(block.chainid == 11155111){
    // Sepolia
} else if(block.chainid == 1){
    // Mainnet
} else {
    // Local Anvil (deploy mock)
}
```
---

## 🔗 Price Feed Handling
- Network	            Behavior
- 🧪 Anvil	   Deploys MockV3Aggregator (simulated price)
- 🌐 Sepolia	 Uses real Chainlink price feed
- 🏛️ Mainnet	 Uses official Chainlink feed

---

## 💡 Why This is Powerful
- ❌ No hardcoded addresses
- ✅ Works across environments
- ✅ Real-world deployment strategy
- ✅ Clean and scalable architecture

---

## ⚙️ Core Contract Logic
💸 Funding
```
require(
    msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD,
    "Not enough fund."
);
```
---

## 🔐 Withdrawal

- Resets all funders
- Uses low-level call for gas efficiency
 ``` 
(bool success,) = payable(msg.sender).call{value: address(this).balance}("");
require(success, "call fails");
```
---

## 🧪 Testing
✅ Unit Tests (FundMeTest)
- Minimum USD validation
- Owner checks
- Funding logic
- Mapping updates
- Withdraw restrictions

---

## 🔁 Integration Tests (InteractionTest)
- Full flow: fund → withdraw
- Multi-user simulation
- Script interaction testing

---

## ▶️ Run Tests
```
forge test
```
Verbose:
```
forge test -vvv
```

---

## 🚀 Getting Started
1. Clone Repo
```
git clone https://github.com/your-username/foundry-fundme.git
cd foundry-fundme
```
2. Install Foundry
```
curl -L https://foundry.paradigm.xyz | bash
foundryup
```
3. Build
```
forge build
```
4. Run Local Chain
```
anvil
```
5. Deploy Contract
```
forge script script/DeployFundMe.s.sol \
--rpc-url http://127.0.0.1:8545 \
--private-key <PRIVATE_KEY> \
--broadcast
```

---

## 🔁 Interacting with Contract
Fund
```
forge script script/Interaction.s.sol \
--sig "run()" \
--rpc-url <RPC_URL> \
--private-key <PRIVATE_KEY> \
--broadcast
```

---

## Withdraw

Same script handles withdraw via WithdrawFundMe.

---

## 📖 What I Learned
- Using libraries (PriceConverter)
- Integrating Chainlink oracles
- Writing secure withdrawal patterns
- Managing multi-network configs
- Writing unit + integration tests
- Automating workflows using Foundry scripts

---

## 💡 Future Improvements
- 🌐 Add frontend (React + Ethers.js)
- 🪙 Support ERC20 funding
- 📊 Add events & indexing
- 🔐 Add access control improvements
- 🚀 Deploy on multiple testnets

---

## 🤝 Connect with Me
- 💼 Aspiring Blockchain Developer
- 🌱 Learning Smart Contracts & Web3

---

## ⭐ Show Your Support

If you like this project, give it a ⭐ on GitHub!

---

## 📄 License

MIT License
