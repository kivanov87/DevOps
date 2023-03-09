#!/bin/bash

echo -e "\033[0;36mDownload Prometheus\033[0m"
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

tar xzvf prometheus-2.42.0.linux-amd64.tar.gz


cat << EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 20s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['node:9090']
EOF
