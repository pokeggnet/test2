# Use an image that has systemd installed
FROM centos/systemd

# Install necessary packages
RUN yum -y update && \
    yum -y install shellinabox systemd curl gnupg2 wsl && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install PowerShell
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/microsoft-prod.list && \
    yum -y update && \
    yum -y install powershell && \
    yum clean all && \
    rm -rf /var/cache/yum

# Add wsl.conf
RUN echo "[boot]\n\
systemd=true\n\
[interop]\n\
enabled=true\n\
appendWindowsPath=true\n\
" >> /etc/wsl.conf

RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
