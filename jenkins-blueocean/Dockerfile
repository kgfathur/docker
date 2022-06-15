FROM jenkins/jenkins:2.319.3-lts-rhel-ubi8-jdk11
USER root
RUN curl -fsSLo /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo \
&& dnf install -y wget docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.2 docker-workflow:1.28"