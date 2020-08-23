FROM ubuntu:latest

LABEL maintainer="Felipe Andrade"
LABEL homepage="https://github.com/felipeAndrade0918/docker-aws-kubectl"

USER root

# Install Docker cli
RUN apt-get update && \
    apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

RUN apt-get install lsb-core -y

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && \
    apt-get install docker-ce-cli -y

# Install AWS cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    apt-get install unzip && \
    unzip awscliv2.zip  && \
    ./aws/install

#Install Kubectl
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl