# Use a base image that supports systemd (Ubuntu)
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y systemd shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable SSH service for the web-based terminal
RUN echo "root:root" | chpasswd

# Expose the SSH port (22) for the web-based terminal
EXPOSE 4200

# Enable services to run under systemd
RUN systemctl enable shellinabox.service
RUN /usr/bin/shellinaboxd --no-beep -t --disable-ssl --service 
CMD ["/lib/systemd/systemd"]
