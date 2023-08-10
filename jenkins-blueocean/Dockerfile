# FROM jenkins/jenkins:2.319.3-lts-rhel-ubi8-jdk11
FROM jenkins/jenkins:lts-rhel-ubi9-jdk17
USER root
RUN curl -fsSLo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo \
  && dnf install -y wget docker-ce-cli \
  && jenkins-plugin-cli --plugins "blueocean:1.27.5"
USER jenkins