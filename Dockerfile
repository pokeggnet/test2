# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-9-jdk git maven && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Clone the Bastillion repository
RUN git clone https://github.com/bastillion-io/Bastillion.git

# Build and install Bastillion
RUN cd Bastillion && \
    export JAVA_HOME=/usr/lib/jvm/java-9-openjdk-amd64 && \
    export M2_HOME=/usr/share/maven && \
    export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH && \
    mvn package jetty:run

# Expose the Bastillion web interface port
EXPOSE 8080

# Start Bastillion
CMD ["java", "-jar", "target/bastillion-upgrade-4.00.01.jar"]
