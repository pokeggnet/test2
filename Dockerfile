# Use a lightweight base image (e.g., Alpine Linux)
FROM alpine:latest

# Create a directory for your web app
RUN mkdir -p /webapp

# Copy your HTML file for the web-based shell to the container
COPY shell.html /webapp/index.html

# Install a basic web server (BusyBox's httpd)
RUN apk add --no-cache busybox

# Expose a port (e.g., 8080) for web access
EXPOSE 8080

# Start the web server to serve the web-based shell
CMD ["/bin/httpd", "-p", "8080", "-h", "/webapp"]
