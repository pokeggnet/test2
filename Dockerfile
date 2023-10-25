# Use a base image with Ubuntu 20.04
FROM ubuntu:20.04

# Set the DEBIAN_FRONTEND environment variable to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    systemd \
    systemd-sysv \
    shellinabox \
    && rm -rf /var/lib/apt/lists/*

# Expose Shell In A Box port
EXPOSE 4200

# Start systemd and Shell In A Box when the container starts
CMD ["/sbin/init"]
