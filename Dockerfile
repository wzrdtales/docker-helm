############################################################
# Dockerfile
############################################################

# Set the base image
FROM alpine:3.8

############################################################
# Configuration
############################################################
ENV VERSION "2.4.0"
ENV FILENAME=helm-v${VERSION}-linux-amd64.tar.gz

############################################################
# Entrypoint
############################################################
COPY docker-entrypoint.sh /usr/local/bin/

############################################################
# Installation
############################################################

RUN apk add --no-cache ca-certificates bash git curl tar gzip coreutils &&\
    # Install Helm
    curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME}> ${FILENAME} &&\
    tar zxv -C /tmp -f ${FILENAME} &&\
    rm -f ${FILENAME} &&\
    mv /tmp/linux-amd64/helm /bin/helm &&\
    chmod +x /usr/local/bin/docker-entrypoint.sh &&\
    # CleanUp
    apk del curl tar gzip

############################################################
# Execution
############################################################
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["helm", "--help"]
