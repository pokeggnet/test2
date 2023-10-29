# Use the systemd-enabled Ubuntu image
FROM jrei/systemd-ubuntu:20.04

# Install necessary packages and configure systemd services
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the root password (replace 'root_password' with your desired password)
RUN echo 'root:root_password' | chpasswd

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox as a systemd service
CMD ["/lib/systemd/systemd"]
