# Use a base image with systemd (e.g., Arch Linux)
FROM archlinux/base

# Update system and install necessary packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm yay shellinabox && \
    pacman -Scc --noconfirm && \
    rm -rf /var/cache/pacman/pkg/*

# Set the root user password to "root"
RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port (4200 by default)
EXPOSE 4200

# Start Shellinabox directly
CMD ["/usr/bin/shellinaboxd", "--no-beep", "-t", "--disable-ssl", "--service", "/:LOGIN"]
