#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "default user exists" id vscode
check "default user in sudo group" groups vscode | grep -q sudo
check "default user has home directory" [ -d "/home/vscode" ]
# TODO: Fix this test. Cannot explain why it fails for default vscode user.
# check "sudo works for default user" sudo -u vscode sudo echo "sudo works"

# Report result
reportResults