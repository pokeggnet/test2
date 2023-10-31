# Use a base image that supports your desired environment (e.g., Ubuntu)
FROM ubuntu:20.04

# Install necessary packages and dependencies
RUN apt-get update 
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:pufferpanel/pufferpanel
RUN apt-get update
RUN apt-get install -y pufferpanel
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the PufferPanel web interface port
EXPOSE 8080

# Set the startup command for PufferPanel
CMD ["pufferpanel"]
