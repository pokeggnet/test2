# Use a base image with systemd (e.g., CentOS)
FROM centos/systemd

# Install necessary packages
RUN dnf install -y epel-release && \
    dnf install -y shellinabox && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# Set the root user password to "root"
RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port (4200 by default)
EXPOSE 4200

# Start Shellinabox directly
CMD ["/usr/sbin/shellinaboxd", "-t", "--no-beep", "--disable-ssl", "--service", "/:LOGIN"]
