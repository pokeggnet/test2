FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get install -y curl && \
    apt-get install -y gnupg2 && \
    apt-get install -y wsl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PowerShell
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get update && \
    apt-get install -y powershell && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
