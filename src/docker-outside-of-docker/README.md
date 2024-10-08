
# docker-outside-of-docker (docker-outside-of-docker)

Re-use the host docker socket, adding the Docker CLI to container. Code is inspared from https://github.com/cirolosapio/devcontainers-features/tree/main/src/alpine-docker-outside-of-docker for that feature

## Example Usage

```json
"features": {
    "ghcr.io/davzucky/devcontainers-features-wolfi/docker-outside-of-docker:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| installDocker | Install Docker | boolean | true |
| installBuilx | Install Buildx | boolean | true |
| installDockerCompose | Install Docker Compose | boolean | true |

## Customizations

### VS Code Extensions

- `ms-azuretools.vscode-docker`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/davzucky/devcontainers-features-wolfi/blob/main/src/docker-outside-of-docker/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
