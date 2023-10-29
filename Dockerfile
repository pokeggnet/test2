# Use a suitable base image
FROM ubuntu:20.04

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2023-06-13"

ENV container docker

# Enable apt repositories.
RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

# Install necessary packages including systemd and shellinabox
RUN apt-get update \
    && apt-get install -y systemd shellinabox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the web-based terminal port
EXPOSE 4200

# Start Shellinabox and systemd
CMD /lib/systemd/systemd
