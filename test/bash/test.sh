#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'bash' feature with no options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "bash version" bash --version
check "run bash command" bash -c "echo 'Hello from Bash!'"
check "/bin/bash in /etc/shells" grep -q "^/bin/bash$" /etc/shells

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults