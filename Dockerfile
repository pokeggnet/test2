# Use a base image that supports systemd (CentOS)
FROM centos/systemd

# Install necessary packages
RUN yum -y install epel-release && \
    yum -y install shellinabox && \
    yum clean all && \
    rm -rf /var/cache/yum

# Expose the web-based terminal port (4200 by default)
EXPOSE 4200

# Start Shellinabox directly (bypassing systemctl)
CMD ["/usr/sbin/shellinaboxd", "-t", "--no-beep", "--disable-ssl", "--service", "/:LOGIN"]

