# To deploy
```
./aoa-tools/deploy.sh -f <environment directory>
```

## Installer options
```
Syntax: installer [-f|-o|-i|-h]
options:
-f     path to AoA files
-o     overlay
-i     install infra
-h     print help
```

Note: If `-i` is used, the installer will check for a folder named `.infra` in the environment directory and will install the infra before running the script. This currently only supports k3d for local deployments

## vars.env
If a `vars.env` exists in the demo environment directory then it will be treated as the source of truth for the installation. Leverage the `vars.env` to specify different cluster contexts and environment overlays as well as github username, repo name, and branch when using a fork of this repo.

If a `vars.env` is not present, the installer will use any passed in flags and attempt to discover all of the necessary variables in the pre-check. Please verify the output before continuing