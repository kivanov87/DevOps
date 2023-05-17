#!/bin/bash

echo "* Add the Docker repository"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo "* Install the packages (Docker)"
dnf install -y docker-ce docker-ce-cli containerd.io

echo "* Start the Docker service"
sudo systemctl enable --now docker

echo "* Adjust the group membership"
sudo usermod -aG docker vagrant

echo "* Copying prometheus.yml to /tmp/"
sudo cp /vagrant/prom/prometheus.yml /tmp/prometheus.yml

echo "* Starting Prometheus"
cd /vagrant/prom
docker compose up -d