# Use the existing Jenkins agent with Alpine and JDK 21 as the base image
FROM jenkins/agent:alpine-jdk21

# Switch to root to install additional packages
USER root

# Install Python 3 and Docker CLI tools
RUN apk update && apk add --no-cache python3 py3-pip docker

# Ensure Docker service starts automatically
RUN rc-update add docker

# Set the entrypoint to wait indefinitely
ENTRYPOINT ["/bin/sh", "-c", "while true; do sleep 1000; done"]
