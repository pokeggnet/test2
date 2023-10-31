# Use a suitable base image with systemd
FROM ubuntu:20.04

# Enable systemd
ENV container docker

# Install necessary packages
RUN apt-get update && apt-get install -y systemd shellinabox && apt-get clean

# Create a minimal systemd unit for the Docker container
RUN echo "[Unit]" > /etc/systemd/system/container.service && \
    echo "Description=Container" >> /etc/systemd/system/container.service && \
    echo "" >> /etc/systemd/system/container.service && \
    echo "[Service]" >> /etc/systemd/system/container.service && \
    echo "ExecStart=/usr/sbin/init" >> /etc/systemd/system/container.service && \
    echo "Restart=always" >> /etc/systemd/system/container.service && \
    echo "" >> /etc/systemd/system/container.service && \
    echo "[Install]" >> /etc/systemd/system/container.service && \
    echo "WantedBy=multi-user.target" >> /etc/systemd/system/container.service

# Create a startup script
RUN echo "#!/bin/sh" > /start.sh && \
    echo "systemctl enable container.service" >> /start.sh && \
    echo "systemctl start container.service" >> /start.sh && \
    echo "service shellinabox start" >> /start.sh && \
    chmod +x /start.sh

# Expose the web-based terminal port
EXPOSE 4200

# Run the startup script
CMD ["/start.sh"]
