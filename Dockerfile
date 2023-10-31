# Use a suitable base image (e.g., Ubuntu 20.04)
FROM ubuntu:20.04

# Install a minimal shell (e.g., bash)
RUN apt-get update && apt-get install -y bash && apt-get clean

# Expose a port (e.g., 8080) for web access
EXPOSE 8080

# Start a basic web server to serve the shell
CMD ["bash", "-c", "while true; do echo -e 'HTTP/1.1 200 OK\n\n$(bash)'; done | nc -l -p 8080"]
