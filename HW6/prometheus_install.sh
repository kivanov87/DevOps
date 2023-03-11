#!/bin/bash

echo -e "\033[0;36mDownload Prometheus\033[0m"
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

sudo tar xzvf prometheus-2.42.0.linux-amd64.tar.gz

yum clean all

docker volume create grafana


cat << EOF > prometheus-2.42.0.linux-amd64/prometheus.yml
global:
  scrape_interval: 20s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['node1:9090']  
  - job_name: 'debian'
    static_configs:
    - targets: ['node2:9100']
  - job_name: 'centos'
    static_configs:
    - targets: ['node3:9100']

EOF
