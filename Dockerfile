# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl build-essential python3 libncurses-dev flex libssl-dev bc bison git && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Wetty
RUN npm install -g wetty

# Expose the Wetty web interface port
EXPOSE 8080

# Start Wetty
CMD ["wetty", "--port", "8080"]
