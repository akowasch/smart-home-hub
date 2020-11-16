FROM nodered/node-red:latest-12

USER root

# Install tools
RUN set -ex \
    && apk add --no-cache \
      avahi-compat-libdns_sd \
      ffmpeg

USER node-red
