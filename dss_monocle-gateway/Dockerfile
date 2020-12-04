ARG BUILD_FROM=hassioaddons/base:8.0.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# ---------------------------------------
# Create Monocle Gateway configuration 
# directory
# ---------------------------------------
RUN mkdir -p /tmp/monocle
RUN mkdir -p /etc/monocle

# Setup base system
ARG BUILD_ARCH=amd64
# hadolint ignore=SC2181

# ---------------------------------------
# Install Monocle Gateway dependencies
# and other useful utilties
# ---------------------------------------
RUN apk update &&      \
    apk add --no-cache \
    wget               \
    curl               \
    libstdc++          \
    nano               \
    net-tools          \
    openssl            \
    ca-certificates

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
RUN wget -c https://files.monoclecam.com/monocle-gateway/linux/monocle-gateway-alpine-x64-v0.0.4.tar.gz -O /tmp/monocle/monocle-gateway.tar.gz && \
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
    io.hass.name="DSS Monocle Gateway" \
    io.hass.description="DSS Monocle Gateway Add-On" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="https://github.com/sdesalve" \
    org.opencontainers.image.title="Addon Monocle Gateway for ${BUILD_ARCH}" \
    org.opencontainers.image.description="Monocle Gateway for Home Assistant" \
    org.opencontainers.image.vendor="SDeSalve.it" \
    org.opencontainers.image.authors="SDeSalve <me@sdesalve.it>" \
    org.opencontainers.image.licenses="CC Attribution-NonCommercial 4.0 International" \
    org.opencontainers.image.url="https://sdesalve.it" \
    org.opencontainers.image.source="https://github.com/sdesalve/hassio-addons/tree/master/dss_monocle-gateway" \
    org.opencontainers.image.documentation="https://github.com/sdesalve/hassio-addons/tree/master/dss_monocle-gateway/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}    
