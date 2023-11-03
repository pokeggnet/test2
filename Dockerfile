FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo 'root:root' | chpasswd
# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]

# Install Docker inside the container
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Modify Docker configuration to use the host's Docker socket
RUN echo 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' >> /etc/default/docker

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
