#!/bin/bash

ARCH=$(uname -m)
OS=$(uname -s)

# rm ipfs rubixgoplatform swarm.key testswarm.key rubix-*.tar.gz 

if [ "$OS" = "Darwin" ] && [ "$ARCH" = "arm64" ]; then
    echo "Detected macOS ARM (Apple Silicon): $ARCH"
    wget https://learn.rubix.net/executables/macos/arm/rubix-macos-arm-bundle.tar.gz
    tar -xzf rubix-macos-arm-bundle.tar.gz
    rm rubix-macos-arm-bundle.tar.gz
elif [ "$OS" = "Linux" ] && ([ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]); then
    echo "Detected Linux ARM architecture: $ARCH"
    wget https://learn.rubix.net/executables/linux/arm/rubix-linux-arm-bundle.tar.gz
    tar -xzf rubix-linux-arm-bundle.tar.gz
    rm rubix-linux-arm-bundle.tar.gz
elif [ "$ARCH" = "x86_64" ]; then
    echo "Detected AMD64 architecture: $ARCH"
    wget https://learn.rubix.net/executables/linux/amd/rubix-linux-amd-bundle.tar.gz
    tar -xzf rubix-linux-amd-bundle.tar.gz
    rm rubix-linux-amd-bundle.tar.gz
else
    echo "Unsupported OS/architecture combination: $OS/$ARCH"
    exit 1
fi


chmod +x rubixgoplatform ipfs
./rubixgoplatform -v

