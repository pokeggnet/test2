# Use an image that has systemd installed
FROM centos/systemd

# Install necessary packages
RUN yum -y update && \
    yum -y install shellinabox systemd curl gnupg2 wsl && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
