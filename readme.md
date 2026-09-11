# Setup GDScript Formatter

A GitHub Action to install a specific version of **[GDScript Formatter](https://github.com/GDQuest/GDScript-formatter)** with optional caching support.

## Versioning

> [!IMPORTANT]
> This action does not use major version tags. Releases are immutable, so pin the action to a specific release version to ensure reproducible workflows.

## Inputs

| Name | Description | Default |
| --- | --- | --- |
| `version` | Version of GDScript Formatter to install. | - |
| `cache` | Whether to cache the GDScript Formatter installation. | `false` |

## Cache

Set `cache` to `true` to enable caching and avoid downloading the same version on every workflow run.

```yaml
with:
  cache: true
```

## Supported Platforms

This action supports the following platforms:

| OS | Architecture |
| --- | --- |
| Linux | x86_64 |
| Linux | aarch64 |
| macOS | x86_64 |
| macOS | aarch64 |
| Windows | x86_64 |
| Windows | aarch64 |

## Example Workflow

```yaml
name: Format Check

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  format:
    runs-on: ubuntu-22.04

    steps:
      - name: Checkout
        uses: actions/checkout@v7

      - name: Setup GDScript Formatter
        uses: DevTwilight/setup-gdscript-formatter@v1.0.0
        with:
          version: 0.21.0
          cache: true

      - name: Verify version
        run: gdscript-formatter --version
```        