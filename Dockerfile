# Use the systemd-enabled Ubuntu image
FROM jrei/systemd-ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the root password (replace 'root_password' with your desired password)
RUN echo 'root:root_password' | chpasswd

# Expose the web-based terminal port
EXPOSE 4200

# Create a systemd service unit for Shell In A Box
RUN echo "[Unit]" > /etc/systemd/system/shellinabox.service && \
    echo "Description=Web-based SSH via Shell In A Box" >> /etc/systemd/system/shellinabox.service && \
    echo "" >> /etc/systemd/system/shellinabox.service && \
    echo "[Service]" >> /etc/systemd/system/shellinabox.service && \
    echo "ExecStart=/usr/bin/shellinaboxd -t -s /:LOGIN" >> /etc/systemd/system/shellinabox.service && \
    echo "" >> /etc/systemd/system/shellinabox.service && \
    echo "[Install]" >> /etc/systemd/system/shellinabox.service && \
    echo "WantedBy=multi-user.target" >> /etc/systemd/system/shellinabox.service

# Start systemd and enable the Shell In A Box service
CMD ["/lib/systemd/systemd"]
