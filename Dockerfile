# Use a suitable base image
FROM ubuntu:20.04

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2023-06-13"

ENV container docker

# Enable apt repositories.
RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

# Install necessary packages including systemd and shellinabox
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y systemd shellinabox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ "$i" == "systemd-tmpfiles-setup.service" ] || rm -f $i; done) \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
    && rm -f /etc/systemd/system/*.wants/* \
    && rm -f /lib/systemd/system/local-fs.target.wants/* \
    && rm -f /lib/systemd/system/sockets.target.wants/*udev* \
    && rm -f /lib/systemd/system/sockets.target.wants/*initctl* \
    && rm -f /lib/systemd/system/basic.target.wants/* \
    && rm -f /lib/systemd/system/anaconda.target.wants/* \
    && rm -f /lib/systemd/system/plymouth* \
    && rm -f /lib/systemd/system/systemd-update-utmp*

# Expose the web-based terminal port
EXPOSE 4200

# Start Shellinabox and systemd
CMD ["/lib/systemd/systemd"]
