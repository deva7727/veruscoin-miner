#!/bin/bash

# Update and install dependencies
echo "Updating system and installing dependencies..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install wget unzip tar build-essential -y  # Added build-essential for compiling dependencies

# Download VerusCoin Source
echo "Downloading VerusCoin source code..."
wget https://github.com/VerusCoin/VerusCoin/archive/refs/tags/v1.2.6.tar.gz -O veruscoin-v1.2.6.tar.gz

# Check if the download was successful
if [ ! -f veruscoin-v1.2.6.tar.gz ]; then
    echo "Failed to download VerusCoin source. Exiting..."
    exit 1
fi

# Extract the VerusCoin package
echo "Extracting VerusCoin..."
mkdir veruscoin-v1.2.6-extracted
tar -xvzf veruscoin-v1.2.6.tar.gz -C veruscoin-v1.2.6-extracted

# Change to the extracted directory
cd veruscoin-v1.2.6-extracted/VerusCoin-1.2.6

# Check if the extraction was successful
if [ ! -d "VerusCoin-1.2.6" ]; then
    echo "Failed to extract VerusCoin source. Exiting..."
    exit 1
fi

# Build VerusCoin (if it's not already built)
echo "Building VerusCoin..."
make -j$(nproc)  # Compile using all available cores

# Check if the build was successful
if [ ! -f "./verus" ]; then
    echo "Miner executable 'verus' not found after build. Exiting..."
    exit 1
fi

# Set Mining Pool and Wallet
POOL="stratum+tcp://verushash.mine.zergpool.com:3300"
WALLET="RPXEmxhopTAwM8rkNs3Mx21qnBjbjiQY1f"  # Replace with your VerusCoin wallet address
WORKER_NAME="colab_worker"

# Set the number of threads based on the system's CPU cores
CPU_CORES=$(nproc)  # Automatically detects the number of CPU cores
THREADS=$((CPU_CORES / 2))  # Use half of the available cores for mining, adjust as necessary

# Ensure that the "verus" binary is executable
chmod +x verus  # Make sure 'verus' is executable

# Start Mining
echo "Starting VerusCoin mining with $THREADS threads..."
./verus -o $POOL -u $WALLET.$WORKER_NAME -p c=VRSC --threads $THREADS

# Keep mining running until the script is stopped
echo "Mining started. Press Ctrl+C to stop."
while true; do sleep 60; done
