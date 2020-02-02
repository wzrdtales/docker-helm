# Helm

Docker image containing the Kubernetes Helm Client.

## Features

- helm2 is fixed to 2.12.1 to avoid multiple bugs in later versions and prefer upgrading to helm3 instead
- helm3 available as helm3 to migrate over and just continue using this image
- Tillerless Helm Plugin - [helm-tiller](https://github.com/rimusz/helm-tiller) by @rimusz
- Overwrite the KubeCTL Config with a base64 encoded file by setting the env variable `KUBECONFIG_CONTENT`. Can be usefull for automated deployments from gitlab/travis/...
