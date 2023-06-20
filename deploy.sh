#!/bin/sh

set -e

# Check for proper usage
if (( $# != 1 )); then
    echo "Usage: ./deploy.sh [offline-registry.host.com]"
    exit 1
fi

# Check for proper dependencies
if !((command -v docker) && (command -v tar) && (command -v sed)); then
    echo "This command requires docker, tar, and sed to function"
    exit 1
fi

# Untar the bundle from Hoppr
mkdir -p bundle
tar -xvf bundle.tar.gz -C bundle

# Check the kubectl shasum
echo "fba6c062e754a120bc8105cde1344de200452fe014a8759e06e4eec7ed258a09 bundle/generic/https%3A%2F%2Fdl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl" | sha256sum --check

# Load and push the image to the correct repository
# docker load --input bundle/docker/https%3A%2F%2Fdocker.io/defenseunicorns/zarf-game_multi-tile-dark
# docker tag sha256:be9619e8e2570e0012bd9e71cb3dfcef65ce33b443dcca525de20b4cabad04cd $1/zarf-game:multi-tile-dark
# docker push $1/zarf-game:multi-tile-dark

# Replace the online registry with the offline registry
awk "{gsub(/defenseunicorns\\/zarf-game:multi-tile-dark/, \"$1/zarf-game:multi-tile-dark\")} 1" bundle/generic/https%3A%2F%2Fraw.githubusercontent.com%2Fdefenseunicorns%2Fzarf%2Fmain/examples/dos-games/manifests/deployment.yaml > tmp && mv tmp bundle/generic/https%3A%2F%2Fraw.githubusercontent.com%2Fdefenseunicorns%2Fzarf%2Fmain/examples/dos-games/manifests/deployment.yaml

# Apply the manifests with kubectl
chmod +x bundle/generic/https%3A%2F%2Fdl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl
bundle/generic/https%3A%2F%2Fdl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl apply -f bundle/generic/https%3A%2F%2Fraw.githubusercontent.com%2Fdefenseunicorns%2Fzarf%2Fmain/examples/dos-games/manifests/deployment.yaml
bundle/generic/https%3A%2F%2Fdl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl apply -f bundle/generic/https%3A%2F%2Fraw.githubusercontent.com%2Fdefenseunicorns%2Fzarf%2Fmain/examples/dos-games/manifests/service.yaml
