#!/bin/sh

set -e

# Optional: Import test library bundled with the devcontainer CLI
# source dev-container-features-test-lib

# Feature-specific tests
# check "docker cli" docker --version
# check "docker socket" ls -l /var/run/docker.sock
# check "docker-init script" ls -l /usr/local/share/docker-init.sh

# # Check if docker commands work
# check "docker run hello-world" docker run --rm hello-world | grep "Hello from Docker!"

# # Check if buildx is installed
# check "docker buildx" docker buildx version

# # Check if docker-compose is installed
# check "docker-compose" docker-compose --version

# Report result
# reportResults