# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y ttyd && \
    apt-get install -y systemd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo 'root:root' | chpasswd

# Expose the ttyd web interface port
EXPOSE 8080

# Start ttyd
CMD ["/usr/bin/ttyd", "-p", "8080", "bash"]
