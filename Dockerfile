# Use a suitable base image that uses sysv-init instead of systemd
FROM ubuntu:20.04

# Install the init and sysv-rc-conf packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y init sysv-rc-conf shellinabox && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the web-based terminal port
EXPOSE 4200

# Start Shellinabox and the init process
CMD ["/sbin/init"]
