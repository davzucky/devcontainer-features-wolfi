#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
USERNAME="testuser"
USER_ID="2000"

check "custom user exists" id $USERNAME
check "custom user has correct UID" [ "$(id -u $USERNAME)" = "$USER_ID" ]
check "custom user has correct GID" [ "$(id -g $USERNAME)" = "$USER_ID" ]
check "custom user in sudo group" groups $USERNAME | grep -q sudo
check "custom user has home directory" [ -d "/home/$USERNAME" ]
check "sudo works for custom user" sudo -u $USERNAME sudo echo "sudo works"

# Report result
reportResults