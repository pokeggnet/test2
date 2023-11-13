# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y cockpit && \
    apt-get install -y systemd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo 'root:root' | chpasswd

# Expose the Cockpit web interface port
EXPOSE 8080

# Start Cockpit
CMD ["/usr/sbin/cockpit", "-p", "8080"]
