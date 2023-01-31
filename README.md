# To deploy
```
./aoa-tools/deploy.sh -f <environment directory>
```

Note: If `-i` is used, the installer will check for a folder named `.infra` in the environment directory and will install the infra before running the script. This currently only supports k3d for local deployments

## Installer options
```
Syntax: installer [-f|-o|-i|-h]
options:
-f     path to AoA files
-o     overlay
-i     install infra
-h     print help
```