# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gnupg ca-certificates supervisor shellinabox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Crafty Controller
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    npm install crafty-controller -g

# Expose the Crafty Controller port and the Shellinabox port
EXPOSE 8000 4200

# Start Shellinabox and Crafty Controller when the container starts
CMD service shellinabox start && crafty start
