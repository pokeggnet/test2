# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y build-essential git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Clone the TinyShell repository
RUN git clone https://github.com/creaktive/tsh.git

# Build and install TinyShell
RUN cd tsh && make linux

# Expose the TinyShell web interface port
# Note: You'll need to replace this with the actual port used by your TinyShell application
EXPOSE 8080

# Start TinyShell
# Note: You'll need to replace this with the actual command to start your TinyShell application
CMD ["./tsh localhost:8080"]
