ARG BUILD_FROM=ghcr.io/hassio-addons/base:13.0.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# ---------------------------------------
# Create Monocle Gateway configuration 
# directory
# ---------------------------------------
RUN mkdir -p /tmp/monocle
RUN mkdir -p /etc/monocle

# Setup base system
# hadolint ignore=SC2181

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# ---------------------------------------
# Install Monocle Gateway dependencies
# and other useful utilties
# ---------------------------------------
RUN apk update
RUN apk add --no-cache wget
RUN apk add --no-cache curl
RUN apk add --no-cache libstdc++
RUN apk add --no-cache nano
RUN apk add --no-cache net-tools
RUN apk add --no-cache openssl
RUN apk add --no-cache ca-certificates

# ---------------------------------------
# Download versioned Monocle Gateway
# build archive file
# - - - - - - - - - - - - - - - - - - - -
# Extract Moncole Gateway related 
# executables to the appropriate 
# runtime directories 
# - - - - - - - - - - - - - - - - - - - -
# Remove the downloaded Monocle Gateway 
# archive files
# ---------------------------------------
RUN \
    if [ "${BUILD_ARCH}" = "armhf" ]; then \
    wget -c https://archive.monoclecam.com/monocle-gateway/monocle-gateway-0.0.6-beta/linux/monocle-gateway-alpine-arm64-v0.0.6.tar.gz -O /tmp/monocle/monocle-gateway.tar.gz; \
    elif [ "${BUILD_ARCH}" = "armv7" ]; then \
    wget -c https://archive.monoclecam.com/monocle-gateway/monocle-gateway-0.0.6-beta/linux/monocle-gateway-alpine-arm64-v0.0.6.tar.gz -O /tmp/monocle/monocle-gateway.tar.gz; \
    elif [ "${BUILD_ARCH}" = "aarch64" ]; then \
    wget -c https://archive.monoclecam.com/monocle-gateway/monocle-gateway-0.0.6-beta/linux/monocle-gateway-alpine-arm64-v0.0.6.tar.gz -O /tmp/monocle/monocle-gateway.tar.gz; \
    elif [ "${BUILD_ARCH}" = "i386" ]; then \
    wget -c https://archive.monoclecam.com/monocle-gateway/monocle-gateway-0.0.6-beta/linux/monocle-gateway-alpine-x64-v0.0.6.tar.gz -O /tmp/monocle/monocle-gateway.tar.gz; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then \
    wget -c https://archive.monoclecam.com/monocle-gateway/monocle-gateway-0.0.6-beta/linux/monocle-gateway-alpine-x64-v0.0.6.tar.gz -O /tmp/monocle/monocle-gateway.tar.gz; \
    else \
    echo 'NOT VALID BUILD'; exit 1; \
    fi
    
RUN \
    cd /usr/local/bin/ && \
    tar xvzf /tmp/monocle/monocle-gateway.tar.gz monocle-gateway && \ 
    tar xvzf /tmp/monocle/monocle-gateway.tar.gz monocle-proxy  && \
    rm -Rf /tmp/monocle/

# ---------------------------------------
# Expose required TCP ports 
# (port 443 is required by Amazon for 
# secure connectivity)
# ---------------------------------------
EXPOSE 443/tcp

# ---------------------------------------
# Expose required UDP ports 
# (used for the @proxy method to allow 
# IP cameras to transmit streams via UDP)
# ---------------------------------------
EXPOSE 62000-62100/udp

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]

# Labels
LABEL \
    io.hass.name="DSS Monocle Gateway BETA" \
    io.hass.description="DSS Monocle Gateway Add-On BETA" \
    io.hass.arch="armhf|aarch64|i386|amd64" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/sdesalve" \
    org.opencontainers.image.title="Addon Monocle Gateway for ${BUILD_ARCH}" \
    org.opencontainers.image.description="Monocle Gateway for Home Assistant" \
    org.opencontainers.image.vendor="SDeSalve.it" \
    org.opencontainers.image.authors="SDeSalve <me@sdesalve.it>" \
    org.opencontainers.image.licenses="CC Attribution-NonCommercial 4.0 International" \
    org.opencontainers.image.url="https://sdesalve.it" \
    org.opencontainers.image.source="https://github.com/sdesalve/hassio-addons/tree/master/dss_monocle-gateway-beta" \
    org.opencontainers.image.documentation="https://github.com/sdesalve/hassio-addons/tree/master/dss_monocle-gateway-beta/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}    
