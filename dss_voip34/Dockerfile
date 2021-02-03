ARG BUILD_FROM=hassioaddons/base:8.0.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Environment variables
ENV \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    TERM="xterm-256color"

ENV LANG C.UTF-8

# Copy root filesystem
COPY rootfs /

# Setup base
RUN apk add --no-cache \
    coreutils=8.32-r0 \
    wget=1.20.3-r1 \
    sox \
    pjsua \
    screen \
    bc
    
# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="DSS VoIP Notifier34" \
    io.hass.description="VoIP Notifier for Home Assistant" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="SDeSalve <me@sdesalve.it>" \
    org.opencontainers.image.title="Addon VoIP for ${BUILD_ARCH}" \
    org.opencontainers.image.description="VoIP Notifier for Home Assistant" \
    org.opencontainers.image.vendor="SDeSalve.it" \
    org.opencontainers.image.authors="SDeSalve <me@sdesalve.it>" \
    org.opencontainers.image.licenses="CC Attribution-NonCommercial 4.0 International" \
    org.opencontainers.image.url="https://sdesalve.it" \
    org.opencontainers.image.source="https://github.com/sdesalve/hassio-addons/tree/master/dss_voip34" \
    org.opencontainers.image.documentation="https://github.com/sdesalve/hassio-addons/tree/master/dss_voip34/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}