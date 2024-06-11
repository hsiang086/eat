#!/bin/bash

# Define variables
DOWNLOAD_URL="https://github.com/hsiang086/eat/releases/download/v0.1.0/eat-v0.1.0-x86_64-apple-darwin.zip"
ZIP_FILE="/tmp/eat-v0.1.0-x86_64-apple-darwin.zip"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="eat"

# Check if the system is x86_64-apple-darwin
if [[ $(uname -s) != "Darwin" ]] || [[ $(uname -m) != "x86_64" ]]; then
    echo "This script is only for x86_64-apple-darwin (macOS on Intel) systems."
    exit 1
fi

# Download the binary zip file
curl -L -o $ZIP_FILE $DOWNLOAD_URL

# Unzip the binary
unzip -o $ZIP_FILE -d /tmp

# Ensure the eat binary is executable
chmod +x /tmp/$BINARY_NAME

# Move the binary to /usr/local/bin
sudo mv /tmp/$BINARY_NAME $INSTALL_DIR

# Clean up the downloaded zip file
rm $ZIP_FILE

echo "Installation complete. You can now use the 'eat' command."
