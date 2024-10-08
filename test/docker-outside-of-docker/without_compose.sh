#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "docker cli" docker --version
check "docker socket" ls -l /var/run/docker.sock
check "docker-init script" ls -l /usr/local/share/docker-init.sh

# Check if docker commands work
check "docker run hello-world" docker run --rm hello-world | grep "Hello from Docker!"

# Check if buildx is installed
check "docker buildx" docker buildx version

# Check that docker-compose is not installed
check "docker-compose not installed" bash -c "! command -v docker-compose"

# Report result
reportResults