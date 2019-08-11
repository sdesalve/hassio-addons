ARG BUILD_FROM=alpine:3.10.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Environment variables
ENV \
    HOME="/root" \
    LANG="C.UTF-8" \
    PS1="$(whoami)@$(hostname):$(pwd)$ " \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    TERM="xterm-256color"

# Copy root filesystem
COPY rootfs /

# Copy yq
ARG BUILD_ARCH=amd64
COPY bin/yq_${BUILD_ARCH} /usr/bin/yq

# Set shell
SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install base system
RUN \
    set -o pipefail \
    \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    \
    && apk add --no-cache --virtual .build-dependencies \
        tar=1.32-r0 \
    \
    && apk add --no-cache \
        libcrypto1.1=1.1.1c-r0 \
        libssl1.1=1.1.1c-r0 \
        musl-utils=1.1.22-r2 \
        musl=1.1.22-r2 \
    \
    && apk add --no-cache \
        bash=5.0.0-r0 \
        curl=7.65.1-r0 \
        jq=1.6-r0 \
        tzdata=2019a-r0 \
    \
    && apk add --no-cache \
        sox=14.4.2-r5 \
        pjsua=2.8-r0 \
        screen=4.6.2-r0 \
    \
    && S6_ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "i386" ]; then S6_ARCH="x86"; fi \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then S6_ARCH="arm"; fi \
    \
    && curl -L -s "https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-${S6_ARCH}.tar.gz" \
        | tar zxvf - -C / \
    \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && curl -J -L -o /tmp/bashio.tar.gz \
        "https://github.com/hassio-addons/bashio/archive/v0.3.2.tar.gz" \
    && mkdir /tmp/bashio \
    && tar zxvf \
        /tmp/bashio.tar.gz \
        --strip 1 -C /tmp/bashio \
    \
    && mv /tmp/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    \
    && apk del --purge .build-dependencies \
    && rm -f -r \
        /tmp/*

# Entrypoint & CMD
ENTRYPOINT ["/init"]

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="base" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="SDeSalve <me@sdesalve.it>" \
    org.label-schema.description="SDeSalve VoIP addon: ${BUILD_ARCH} image" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon VoIP for ${BUILD_ARCH}" \
    org.label-schema.schema-version="1.0.8" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/sdesalve/hassio-addons/dss_voip/README.md" \
    org.label-schema.vcs-ref=${REF} \
    org.label-schema.vcs-url="https://github.com/sdesalve/hassio-addons/dss_voip" \
    org.label-schema.vendor="SDeSalve"
