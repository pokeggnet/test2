# Use an official CentOS image as a parent image
FROM centos:7

# Install necessary packages
RUN yum -y update && \
    yum -y install systemd shellinabox && \
    yum clean all

# Remove unnecessary systemd services
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

# Configure Shell In A Box
RUN sed -i 's/--no-beep/--no-beep --disable-ssl/g' /etc/sysconfig/shellinaboxd
RUN echo 'root:root' | chpasswd
# Expose the Shell In A Box port
EXPOSE 4200

# Create a script that starts systemd and Shell In A Box
RUN echo '#!/bin/bash' > /start.sh && \
    echo '/usr/sbin/init &' >> /start.sh && \
    echo '/usr/bin/shellinaboxd --port 4200 --disable-ssl' >> /start.sh && \
    chmod +x /start.sh

# Set the default command to run on boot
CMD ["/start.sh"]
