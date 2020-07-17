ARG BUILD_FROM=hassioaddons/base:7.1.0
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
    coreutils=8.31-r0 \
    wget=1.20.3-r0 \
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
    io.hass.name="DSS VoIP Notifier" \
    io.hass.description="VoIP Notifier for HomeAssistant" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="SDeSalve <me@sdesalve.it>" \
    org.label-schema.description="VoIP Notifier for HomeAssistant" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon VoIP for ${BUILD_ARCH}" \
    org.label-schema.schema-version="3.3.3" \
    org.label-schema.url="https://sdesalve.it" \
    org.label-schema.usage="https://github.com/sdesalve/hassio-addons/dss_voip/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/sdesalve/hassio-addons/dss_voip" \
    org.label-schema.vendor="SDeSalve"
