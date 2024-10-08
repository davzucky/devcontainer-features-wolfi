#!/bin/sh
set -e

echo "Installing Bash..."

# Install Bash
apk update
apk add --no-cache bash

# Verify installation
if ! command -v bash >/dev/null 2>&1; then
    echo "Bash installation failed"
    exit 1
fi

echo "Bash installed successfully"

# Add /bin/bash to /etc/shells if it's not already there
if ! grep -q "^/bin/bash$" /etc/shells; then
    echo "/bin/bash" >> /etc/shells
    echo "Added /bin/bash to /etc/shells"
else
    echo "/bin/bash is already in /etc/shells"
fi

echo "Bash is now the default shell"