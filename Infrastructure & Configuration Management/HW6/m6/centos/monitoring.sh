#!/usr/bin/env bash

# Install necessary dependencies
sudo yum install -y wget

# Install Prometheus
cd /opt
wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz

sudo tar xzvf prometheus-2.42.0.linux-amd64.tar.gz
sudo mv prometheus-2.42.0.linux-amd64 prometheus
rm prometheus-2.42.0.linux-amd64.tar.gz

# Configure Prometheus
sudo tee /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus Server
After=network.target

[Service]
Type=simple
ExecStart=/opt/prometheus/prometheus --config.file=/opt/prometheus/prometheus.yml

[Install]
WantedBy=multi-user.target
EOF

sudo tee /opt/prometheus/prometheus.yml <<EOF
global:
  scrape_interval:     15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']

  - job_name: 'kafka'
    static_configs:
    - targets: ['192.168.99.100:9092']
EOF

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus

# Install Grafana
sudo yum install -y https://dl.grafana.com/oss/release/grafana-8.3.2-1.x86_64.rpm

# Configure Grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# Set up Grafana data source
sleep 10 # wait for Grafana to start
curl -XPOST -H "Content-Type: application/json" -d '{"name":"Kafka","type":"prometheus","url":"http://localhost:9090","access":"proxy","isDefault":true}' http://admin:admin@localhost:3000/api/datasources

# Import Grafana dashboard
curl -XPOST -H "Content-Type: application/json" -d @/vagrant/dashboard.json http://admin:admin@localhost:3000/api/dashboards/db

