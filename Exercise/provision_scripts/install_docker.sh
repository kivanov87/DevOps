#!/bin/bash
echo -e "\033[0;36Add Docker repository\033[0m"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo -e "\033[0;36mInstall Docker\033[0m"
dnf install -y docker-ce docker-ce-cli containerd.io git 

echo -e "\033[0;36mStart Docker service\033[0m"
systemctl enable --now docker

echo -e "\033[0;36mAdjust group membership\033[0m"
usermod -aG docker vagrant
usermod -aG wheel vagrant

echo "* Install the packages (Java, git, Docker)"
dnf update
dnf install -y fontconfig openjdk-17-jre 
dnf -y install git

echo "* Adjust the group membership"
usermod -aG docker vagrant

echo "* Download Jenkins CLI"
wget http://192.168.99.100:8080/jnlpJars/jenkins-cli.jar
