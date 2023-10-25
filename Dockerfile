# Use a base image with Ubuntu 20.04
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    systemd \
    systemd-sysv \
    && rm -rf /var/lib/apt/lists/*

# Prevent systemd services from starting during build
RUN systemctl set-default multi-user.target
RUN systemctl mask dev-hugepages.mount sys-fs-fuse-connections.mount

# Start systemd on container startup
CMD ["/lib/systemd/systemd"]
