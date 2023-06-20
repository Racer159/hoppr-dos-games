# hoppr-dos-games

An implementation of the Zarf [DOS Games/Retro Arcade](https://docs.zarf.dev/examples/dos-games/) example in [Hoppr](https://hoppr.dev/)

## Making a Bundle

```
hopctl bundle hoppr-manifest.yaml -t hoppr-transfers.yaml
```

> :warning: NOTE: normally Hoppr manifests are `manifest.yaml` and Hoppr transfers are `transfer.yaml` - this repo uses different names to distinguish them as hoppr-specific files.

# Deploying DOS Games

To deploy you need to have the following:

1. The bundle created in the root of the project with the name of `bundle.tar.gz`
2. An available image registry and k8s cluster
3. `docker`, `tar`, and `awk` available on your system

Then you can run the following:

```
./deploy.sh [offline-registry.host.com]
```
