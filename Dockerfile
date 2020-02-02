############################################################
# Dockerfile
############################################################

# Set the base image
FROM alpine:3.8

############################################################
# Configuration
############################################################
ENV VERSION "2.12.1"
ENV FILENAME=helm-v${VERSION}-linux-amd64.tar.gz
ENV VERSION3 "3.0.3"
ENV FILENAME3=helm-v${VERSION3}-linux-amd64.tar.gz

############################################################
# Entrypoint
############################################################
COPY rootfs /

############################################################
# Installation
############################################################

RUN apk add --no-cache ca-certificates bash git curl tar gzip coreutils &&\
    # Install Helm
    curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME}> ${FILENAME} &&\
    tar zxv -C /tmp -f ${FILENAME} &&\
    rm -f ${FILENAME} &&\
    mv /tmp/linux-amd64/helm /bin/helm &&\
    curl -L https://get.helm.sh/${FILENAME3} > ${FILENAME3} &&\
    tar zxv -C /tmp -f ${FILENAME3} &&\
    rm -f ${FILENAME3} &&\
    mv /tmp/linux-amd64/helm /bin/helm3 &&\
    # Plugins
    helm init --client-only &&\
    # - Tiller Plugin for Tillerless-Helm
    helm plugin install https://github.com/rimusz/helm-tiller &&\
    # - Plugin to diff between the latest deployed version of a release and a helm upgrade --debug --dry-run
    helm plugin install https://github.com/databus23/helm-diff &&\
    # - Nukes all releases
    helm plugin install https://github.com/adamreese/helm-nuke &&\
    # - Keep plugins save
    mkdir -p /helm-plguins /helm-plguins-cache &&\
    cp -r ~/.helm/plugins/* /helm-plguins &&\
    cp -r ~/.helm/cache/plugins/* /helm-plguins-cache

############################################################
# Execution
############################################################
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["helm", "--help"]
