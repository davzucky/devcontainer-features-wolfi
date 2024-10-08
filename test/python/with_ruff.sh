#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "python version" python --version
check "pip version" pip --version

# Check Ruff installation
check "ruff version" ruff --version

# Ensure uv is not installed
check "uv not installed" bash -c "! command -v uv"

# Report result
reportResults