# Unreal Marketplace Build Machines

To goal of this repository is to provide extendable github workflow for common requirements of Unreal Engine plugins.

# Compile Plugin

## Goal

Runs the `ue4 package` CLI command against the repository using the official Linux Docker image provided by Epic Games (`unreal-engine:dev-slim`).

## Setup

You will need a GitHub user with `READ` access to `ghcr.io/epicgames`.

The compile step has **required** 2 secrets: `DOCKER_TOKEN` and `DOCKER_USERNAME`.

Those can be provided as arguments via:

```
    uses:  outoftheboxplugins/BuildMachines/.github/workflows/compile-plugin.yml@master
    secrets:
      DOCKER_TOKEN: ${{ secrets.DOCKER_TOKEN }}
      DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
```

or defined at repository / organisation level and passed via:

```
    uses:  outoftheboxplugins/BuildMachines/.github/workflows/compile-plugin.yml@master
    secrets: inherit
```

Optionally you can pass in a specific UE version via the `ue_version` input parameter.

```
    uses:  outoftheboxplugins/BuildMachines/.github/workflows/compile-plugin.yml@master
    with:
        ue_version: "5.2"
    secrets: inherit
```

# Release Plugin

## Goal

Sets the `VersionName` of the `uplugin` file to match the tag and creates a GitHub release.

## Setup

No required inputs, this can be added to your workflow via:

```
    uses:  outoftheboxplugins/BuildMachines/.github/workflows/release-plugin.yml@master
```

By default the step uses the repository name to find the `.uplugin` file. If they are different, you can supply the name of the plugin via the `plugin_name` input parameter.

```
    uses:  outoftheboxplugins/BuildMachines/.github/workflows/release-plugin.yml@master
    with:
      plugin_name: Aptabase
```

# Package Plugin

- currently used by myself to upload plugins to Google Drive so I can submit them to the UE marketplace. Docs to be done soon.
