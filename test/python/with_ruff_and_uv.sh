#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "python version" python --version
check "pip version" pip --version

# Check Ruff installation
check "ruff version" ruff --version

# Check uv installation
check "uv version" uv --version

# Report result
reportResults