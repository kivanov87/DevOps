#!/bin/bash

echo -e "\033[0;36mDocker Swarm Init\033[0m"
docker swarm init --advertise-addr 192.168.99.100

echo -e "\033[0;36mAdd Vagrant user to Wheel Group\033[0m"
usermod -aG wheel vagrant

echo -e "\033[0;36mCopying daemon.json to /etc/docker/\033[0m"
sudo cp /vagrant/daemon.json /etc/docker/daemon.json

echo -e "\033[0;36mRestarting docker to detect changes in daemon.json\033[0m"
sudo systemctl daemon-reload
sudo systemctl restart docker 

echo -e "\033[0;36mStarting Grafana 8.2.0 as container on port 3000\033[0m"
docker run -d -p 3000:3000 --name grafana grafana/grafana-oss:8.2.0

echo -e "\033[0;36mCopying prometheus.yml to /tmp/\033[0m"
sudo cp /vagrant/prometheus.yml /tmp/prometheus.yml

echo -e "\033[0;36mStarting Prometheus as a Service in the Swarm\033[0m"
cd /vagrant
docker compose up -d

echo -e "\033[0;36mStarting 2 containers from goprom image\033[0m"
docker container run -d --name worker1 -p 8081:8080 shekeriev/goprom
docker container run -d --name worker2 -p 8082:8080 shekeriev/goprom