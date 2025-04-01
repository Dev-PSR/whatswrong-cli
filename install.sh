#!/bin/bash

set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_URL="https://raw.githubusercontent.com/dev-psr/whatswrong-cli/main/whatswrong"

echo "[*] Installing whatswrong CLI..."

# Download the script
curl -sL "$SCRIPT_URL" -o /tmp/whatswrong

# Make it executable
chmod +x /tmp/whatswrong

# Move to global bin directory (may require sudo)
sudo mv /tmp/whatswrong "$INSTALL_DIR/whatswrong"

echo "[✓] Installed successfully. You can now run 'whatswrong' from anywhere."
