#!/usr/bin/env bash

set -euo pipefail

INSTALL_DIR="/usr/local/bin"
SCRIPT_URL="https://raw.githubusercontent.com/dev-psr/whatswrong-cli/main/whatswrong"
TMP_PATH="/tmp/whatswrong"

echo "Installing whatswrong CLI..."

# Step 1: Check for curl
if ! command -v curl &>/dev/null; then
  echo "'curl' is required but not installed. Please install curl and retry."
  exit 1
fi

# Step 2: Download script
echo "Downloading script..."
curl -sL "$SCRIPT_URL" -o "$TMP_PATH"
chmod +x "$TMP_PATH"

# Step 3: Try moving to /usr/local/bin, fallback to ~/.local/bin
if sudo mv "$TMP_PATH" "$INSTALL_DIR/whatswrong" 2>/dev/null; then
  echo "Installed to $INSTALL_DIR"
else
  echo "[!] Could not install to $INSTALL_DIR (permission denied). Trying user bin..."
  mkdir -p "$HOME/.local/bin"
  mv "$TMP_PATH" "$HOME/.local/bin/whatswrong"
  echo "Installed to $HOME/.local/bin"

  # Suggest adding to PATH if needed
  if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo
    echo "[!] $HOME/.local/bin is not in your PATH."
    echo "Add the following to your ~/.bashrc or ~/.zshrc:"
    echo "   export PATH=\"\$HOME/.local/bin:\$PATH\""
  fi
fi

echo
echo "whatswrong installed successfully. Run it with: whatswrong"

