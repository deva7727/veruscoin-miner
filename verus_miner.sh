#!/bin/bash

# Update and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install wget unzip -y

# Download VerusMiner
echo "Downloading VerusMiner..."
wget https://github.com/VerusCoin/VerusCoin/archive/refs/tags/v1.2.6.tar.gz -O veruscoin-v1.2.6.tar.gz

# Extract Miner
echo "Extracting VerusMiner..."
tar -xvzf veruscoin-v1.2.6.tar.gz
cd VerusCoin-1.2.6

# Set Mining Pool and Wallet
POOL="stratum+tcp://verushash.mine.zergpool.com:3300"
WALLET="RPXEmxhopTAwM8rkNs3Mx21qnBjbjiQY1f"  # Replace with your VerusCoin wallet address
WORKER_NAME="colab_worker"

# Set the number of threads based on the system's CPU cores
CPU_CORES=$(nproc)  # Automatically detects the number of CPU cores
THREADS=$((CPU_CORES / 2))  # Use half of the available cores for mining, adjust as necessary

# Start Mining
echo "Starting VerusCoin mining with $THREADS threads..."
./verus -o $POOL -u $WALLET.$WORKER_NAME -p c=VRSC --threads $THREADS

# Keep mining running until the script is stopped
echo "Mining started. Press Ctrl+C to stop."
while true; do sleep 60; done
