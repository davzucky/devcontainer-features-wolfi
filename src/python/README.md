
# python (python)

Installs Python and common Python utilities on Wolfi base images.

## Example Usage

```json
"features": {
    "ghcr.io/davzucky/devcontainers-features-wolfi/python:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| python_version | Select the Python version to install. | string | 3.12 |
| install_ruff | Whether to install Ruff, a fast Python linter and code formatter. | boolean | false |
| install_uv | Whether to install uv, a fast Python package installer and resolver. | boolean | false |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/davzucky/devcontainers-features-wolfi/blob/main/src/python/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
