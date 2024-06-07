FROM jenkins/jenkins:2.414.2-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release python3-pip
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"

# Use the existing Jenkins agent with Alpine and JDK 21 as the base image
FROM jenkins/agent:alpine-jdk21

# Switch to root to install Python
USER root

# Install Python 3
RUN apk update && apk add --no-cache python3

# Switch back to the Jenkins user
USER jenkins

# Set the working directory
WORKDIR /home/jenkins

# Set the entrypoint to wait indefinitely
ENTRYPOINT ["/bin/sh", "-c", "while true; do sleep 1000; done"]
