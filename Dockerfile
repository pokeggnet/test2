# Use a base image with Ubuntu 20.04
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    snapd \
    systemd \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

RUN systemctl start snapd.service
RUN snap install ttyd --classic
# Create a non-root user
RUN useradd -m ubuntu

# Allow user to run sudo without password (for development)
RUN usermod -aG sudo ubuntu
RUN echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Enable SSH and run ttyd on startup
RUN systemctl enable ttyd

# Expose SSH and ttyd ports
EXPOSE 7681

# Start systemd on container startup
CMD ["/lib/systemd/systemd"]
CMD ["ttyd", "bash"]
