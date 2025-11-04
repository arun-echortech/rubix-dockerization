#!/bin/bash

# This script is used by Docker to install the appropriate binaries
# based on the TARGETPLATFORM build argument

TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

case "${TARGETPLATFORM}" in
    "linux/amd64")
        echo "Installing AMD64 version..."
        wget https://learn.rubix.net/executables/linux/amd/rubix-linux-amd-bundle.tar.gz
        tar -xzf rubix-linux-amd-bundle.tar.gz
        rm rubix-linux-amd-bundle.tar.gz
        ;;
    "linux/arm64")
        echo "Installing ARM64 version..."
        wget https://learn.rubix.net/executables/linux/arm/rubix-linux-arm-bundle.tar.gz
        tar -xzf rubix-linux-arm-bundle.tar.gz
        rm rubix-linux-arm-bundle.tar.gz
        ;;
    *)
        echo "Unsupported architecture: ${TARGETPLATFORM}"
        exit 1
        ;;
esac

chmod +x rubixgoplatform ipfs
./rubixgoplatform -v
