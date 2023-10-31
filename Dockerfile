# Use a base image that includes your desired environment (e.g., Ubuntu)
FROM ubuntu:20.04

# Install necessary packages and dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:pufferpanel/pufferpanel && \
    apt-get update && \
    apt-get install -y pufferpanel && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose any necessary ports (e.g., PufferPanel's web interface)
EXPOSE 80

# Set the startup command for PufferPanel
CMD ["pufferpanel"]
