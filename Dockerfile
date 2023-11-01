 # Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox curl gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password
RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port
EXPOSE 4200 5657

# Install PufferPanel
RUN mkdir -p /var/lib/pufferpanel && \
    curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | bash && \
    apt-get install -y pufferpanel

# Start shellinabox and PufferPanel
CMD service shellinabox start && pufferpanel run
