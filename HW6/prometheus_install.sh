#!/bin/bash

echo -e "\033[0;36mDownload Prometheus\033[0m"
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

sudo tar xzvf prometheus-2.42.0.linux-amd64.tar.gz

echo -e "\033[0;36mCreate grafana volume\033[0m"
docker volume create grafana

echo -e "\033[0;36mCreate Prometheus.yaml\033[0m"
cat << EOF > prometheus-2.42.0.linux-amd64/prometheus.yml
global:
  scrape_interval:     15s 
  evaluation_interval: 15s 
  external_labels:
      monitor: 'ADDR'
rule_files:
scrape_configs:
  - job_name: 'dockerProm'
    static_configs:
      - targets: ['192.168.99.100:9090']
      - targets: ['192.168.99.100:9525']
  - job_name: 'goprom'
    static_configs:
      - targets: ['192.168.99.100:8081']
      - targets: ['192.168.99.100:8082']
EOF
echo -e "\033[0;36mStart Prometheus\033[0m"
sudo chmod a+rw /tmp/prometheus.log
cd prometheus-2.42.0.linux-amd64
sudo ./prometheus --config.file prometheus.yml --web.enable-lifecycle 2>> /tmp/prometheus.log &

echo -e "\033[0;36mDocker Swarm Init\033[0m"
docker swarm init --advertise-addr 192.168.99.100

echo -e "\033[0;36mCopying daemon.json to /etc/docker/\033[0m"
sudo cp /vagrant/daemon.json /etc/docker/daemon.json

echo -e "\033[0;36mRestarting docker to detect changes in daemon.json\033[0m"
sudo systemctl daemon-reload
sudo systemctl restart docker 


