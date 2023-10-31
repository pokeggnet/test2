# Use a base image that supports systemd (systemd-debian)
FROM systemd-debian:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the root user password to "root"
RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port (4200 by default)
EXPOSE 4200

# Start Shellinabox directly (bypassing systemctl)
CMD ["/usr/bin/shellinaboxd", "--no-beep", "-t", "--disable-ssl", "--service", "/:LOGIN"]
