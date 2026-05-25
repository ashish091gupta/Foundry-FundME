-include .env

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe \
	--rpc-url $(sp_url) \
	 --account $(mmsp1) \
	 --broadcast \
	 --verify \
	 --etherscan-api-key $(sp_etherscan_key) \
	 -vvv
	