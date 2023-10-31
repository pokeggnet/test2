# Use a suitable base image (e.g., Ubuntu 20.04)
FROM ubuntu:20.04

# Install Python (for a basic HTTP server) and bash (for the shell)
RUN apt-get update && apt-get install -y python3 bash && apt-get clean

# Create a directory for your web app
RUN mkdir /webapp

# Create an HTML file for the web-based shell
RUN echo '<!DOCTYPE html><html><head><title>Web Shell</title></head><body><pre><code>' > /webapp/index.html && \
    echo '<script>var socket = new WebSocket("ws://localhost:8080");' >> /webapp/index.html && \
    echo 'socket.onmessage = function(event) { var term = document.getElementById("terminal"); term.textContent += event.data; };</script>' >> /webapp/index.html && \
    echo '</code><div id="terminal"></div></body></html>' >> /webapp/index.html

# Set the working directory
WORKDIR /webapp

# Expose a port (e.g., 8080) for web access
EXPOSE 8080

# Start a basic Python HTTP server to serve the web-based shell
CMD ["python3", "-m", "http.server", "8080"]
