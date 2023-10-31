# Use a suitable base image
FROM ubuntu:20.04

LABEL maintainer="Robert de Bock <robert@meinit.nl>"
LABEL build_date="2023-06-13"

ENV container docker

# Enable apt repositories.
RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

# Install necessary packages including shellinabox and sysv-rc for service command
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y shellinabox sysv-rc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the web-based terminal port
EXPOSE 4200

# Create a simple init.d service script
RUN echo '#!/bin/sh' > /etc/init.d/my_service \
    && echo '### BEGIN INIT INFO' >> /etc/init.d/my_service \
    && echo '# Provides:          my_service' >> /etc/init.d/my_service \
    && echo '# Required-Start:    $remote_fs $syslog' >> /etc/init.d/my_service \
    && echo '# Required-Stop:     $remote_fs $syslog' >> /etc/init.d/my_service \
    && echo '# Default-Start:     2 3 4 5' >> /etc/init.d/my_service \
    && echo '# Default-Stop:      0 1 6' >> /etc/init.d/my_service \
    && echo '### END INIT INFO' >> /etc/init.d/my_service \
    && echo 'case "$1" in' >> /etc/init.d/my_service \
    && echo 'start)' >> /etc/init.d/my_service \
    && echo '    echo "Starting my_service..."' >> /etc/init.d/my_service \
    && echo '    # Add your startup command here' >> /etc/init.d/my_service \
    && echo '    ;;' >> /etc/init.d/my_service \
    && echo 'stop)' >> /etc/init.d/my_service \
    && echo '    echo "Stopping my_service..."' >> /etc/init.d/my_service \
    && echo '    # Add your stop command here' >> /etc/init.d/my_service \
    && echo '    ;;' >> /etc/init.d/my_service \
    && echo '*)' >> /etc/init.d/my_service \
    && echo '    echo "Usage: $0 {start|stop}"' >> /etc/init.d/my_service \
    && echo '    exit 1' >> /etc/init.d/my_service \
    && echo '    ;;' >> /etc/init.d/my_service \
    && echo 'esac' >> /etc/init.d/my_service \
    && echo 'exit 0' >> /etc/init.d/my_service

# Make the init.d script executable
RUN chmod +x /etc/init.d/my_service

# Start Shellinabox and the custom service
CMD service my_service start && /usr/bin/shellinaboxd
