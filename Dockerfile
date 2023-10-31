# Use a base image that supports your desired environment (e.g., Ubuntu)
FROM ubuntu:20.04

# Install necessary packages and dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PufferPanel
RUN curl -sSL https://pufferpanel.com/install.sh | bash

# Expose the PufferPanel web interface port (default is 8080)
EXPOSE 8080

# Set the startup command for PufferPanel
CMD ["pufferpanel"]
