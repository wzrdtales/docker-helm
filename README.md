# Helm

Docker image containing the Kubernetes Helm Client.

## Features

* Tillerless Helm Plugin - [helm-tiller](https://github.com/rimusz/helm-tiller) by @rimusz
* Overwrite the KubeCTL Config with a base64 encoded file by setting the env variable `KUBECONFIG_CONTENT`. Can be usefull for automated deployments from gitlab/travis/...
