# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
# Install necessary packages
RUN apt-get update && \
    apt-get install -y cockpit && \
    apt-get install -y systemd && \
    apt-get install -y curl && \
    apt-get install -y sudo && \
    apt-get install -y dropbear && \
    apt-get install -y python3 && \
    apt-get clean && \
    curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py && \
    chmod +x /bin/systemctl && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'root:root' | chpasswd

# Expose the Cockpit web interface port
EXPOSE 8080

# Start Cockpit
CMD ["/usr/sbin/cockpit", "-p", "8080"]
