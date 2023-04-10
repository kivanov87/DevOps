#!/bin/bash

echo -e "\033[0;36Add Docker repository\033[0m"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo -e "\033[0;36mInstall Docker\033[0m"
dnf install -y docker-ce docker-ce-cli containerd.io

echo -e "\033[0;36mStart Docker service\033[0m"
systemctl enable --now docker

echo -e "\033[0;36mAdjust group membership\033[0m"
usermod -aG docker vagrant
usermod -aG wheel vagrant
echo -e "\033[0;36mCreate volume grafana\033[0m"
docker volume create grafana

echo -e "\033[0;36mAdjust the firewall\033[0m"
firewall-cmd --add-port 8081/tcp --permanent
firewall-cmd --add-port 8082/tcp --permanent
firewall-cmd --add-port 9090/tcp --permanent
firewall-cmd --add-port 3000/tcp --permanent
firewall-cmd --reload