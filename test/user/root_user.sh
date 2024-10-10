#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "root is the current user" [ "$(id -u)" = "0" ]
check "root is in sudo group" groups root | grep -q sudo
check "no vscode user exists" bash -c "! grep -q \"^vscode:\" /etc/passwd]"

# Report result
reportResults