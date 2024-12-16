#!/bin/bash

# Update and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install wget unzip -y

# Download VerusMiner
echo "Downloading VerusMiner..."
wget https://github.com/VerusCoin/veruscoin/releases/download/v0.10.0/verus-cli-linux.zip -O verus-cli-linux.zip

# Extract Miner
echo "Extracting VerusMiner..."
unzip verus-cli-linux.zip -d verusminer
cd verusminer

# Set Mining Pool and Wallet
POOL="stratum+tcp://verushash.mine.zergpool.com:3300"
WALLET="YOUR_VRSC_WALLET_ADDRESS"  # Replace with your VerusCoin wallet address
WORKER_NAME="colab_worker"

# Start Mining
echo "Starting VerusCoin mining..."
./verus -o $POOL -u $WALLET.$WORKER_NAME -p c=VRSC --threads 2
