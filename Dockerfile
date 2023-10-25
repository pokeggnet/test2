# Use a base image with Ubuntu 20.04
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Set the root password for SSH (change this to a secure password)
RUN echo 'root:root' | chpasswd

# Create a non-root user (you can change the username as needed)
RUN useradd -m test
RUN echo 'test:test' | chpasswd

# Install Node.js for web-based terminal (xterm.js)
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y nodejs

# Install xterm.js
RUN npm install -g xterm

# Expose SSH and web-based terminal ports
EXPOSE 22
EXPOSE 3000

# Start SSH and web-based terminal when the container starts
CMD service ssh start && xterm.js --port 3000
