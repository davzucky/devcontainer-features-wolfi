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

ls -ali /var/run/
# Check if the group owner of /var/run/docker-host.sock is docker
check "docker-host.sock group owner" [ "$(stat -c '%G' /var/run/docker-host.sock)" = "docker" ]
# Check if the owner of /var/run/docker.sock is vscode
check "docker.sock owner" [ "$(stat -c '%U' /var/run/docker.sock)" = "vscode" ]


# Check if buildx is installed
check "docker buildx" docker buildx version

# Check if docker-compose is installed
check "docker-compose" docker-compose --version

# Check if docker-compose is installed
check "docker-compose" docker compose --version

# Report result
reportResults