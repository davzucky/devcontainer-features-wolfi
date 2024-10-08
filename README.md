# devcontainer-features-wolfi

Devcontainer features to build on top of [wolfi base images](https://github.com/wolfi-dev/). This is a distroless base image that a lot of application are using to have a lean container without security vulnerabilities. This allow to create the same developement environment that a team may have using devcontainers.

Most of the features available for devcontainers usually expect you to run a debian (or derived) base image. This is not always the case and some teams want to use a more secure and lean base image like wolfi. 

## Features

At the moment the following features are available:

- [bash](./src/bash/README.md)
- [docker-outside-of-docker](./src/docker-outside-of-docker/README.md)
- [python](./src/python/README.md)

Please let me know if you need other features to be added.

