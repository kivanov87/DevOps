#!/bin/bash

echo -e "\033[0;36mDownload Prometheus\033[0m"
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

sudo tar xzvf prometheus-2.42.0.linux-amd64.tar.gz

echo -e "\033[0;36mCreate grafana volume\033[0m"
docker volume create grafana
echo -e "\033[0;36mCreate application.json\033[0m"

sudo sh -c 'echo "{ \"metrics-addr\": \"0.0.0.0:8081\", \"experimental\": true, \"metrics-addr\": \"0.0.0.0:8082\", \"role\": \"container\" }" > /etc/docker/application.json'

echo -e "\033[0;36mCreate Prometheus.yaml\033[0m"
cat << EOF > prometheus-2.42.0.linux-amd64/prometheus.yml
global:
  scrape_interval: 20s
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - localhost:9090
  - job_name: aplications
    static_configs:
      - targets:
          - localhost:8081
      - targets:
          - localhost:8082
    file_sd_configs:
      - files:
          - application.json
EOF
echo -e "\033[0;36mStart Prometheus\033[0m"
sudo chmod a+rw /tmp/prometheus.log
cd prometheus-2.42.0.linux-amd64
sudo ./prometheus --config.file prometheus.yml --web.enable-lifecycle 2>> /tmp/prometheus.log &