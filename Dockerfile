# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends shellinabox curl gnupg ca-certificates supervisor && \
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

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a supervisord configuration file
RUN echo "[supervisord]\nnodaemon=true\n\n[program:shellinabox]\ncommand=service shellinabox start\n\n[program:pufferpanel]\ncommand=pufferpanel run" > /etc/supervisor/conf.d/supervisord.conf

# Start supervisord
CMD ["/usr/bin/supervisord"]
