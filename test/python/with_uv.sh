#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "python version" python --version
check "pip version" pip --version

# Check uv installation
check "uv version" uv --version

# Ensure Ruff is not installed
check "ruff not installed" bash -c "! command -v ruff"

# Report result
reportResults