#!/bin/bash

# Start Docker daemon with metrics enabled
dockerd --metrics-addr="192.168.99.100:9090" &

#wait
sleep 5

#Docker configuration to Prometheus
cat << EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval:     15s 
  evaluation_interval: 15s 
  external_labels:
      monitor: 'ADDR'
rule_files:
scrape_configs:
  - job_name: 'dockerProm'
    static_configs:
      - targets: ['192.168.99.101:9090']
      - targets: ['192.168.99.101:9525']
  - job_name: 'goprom'
    static_configs:
      - targets: ['192.168.99.101:8081']
      - targets: ['192.168.99.101:8082']
EOF

# Restart Prometheus to pick up new configuration
systemctl restart prometheus

# Create Grafana dashboard
curl -XPOST -H 'Content-Type: application/json' -d '{
  "dashboard": {
    "title": "Docker Metrics",
    "panels": [
      {
        "title": "Containers",
        "type": "gauge",
        "datasource": "Prometheus",
        "targets": [
          {
            "expr": "containers_total"
          }
        ]
      },
      {
        "title": "Jobs by Application",
        "type": "bargauge",
        "datasource": "Prometheus",
        "targets": [
          {
            "expr": "sum by (app, instance_name) (goprom_jobs_total)"
          }
        ],
        "legendFormat": "{{app}} ({{instance_name}})"
      }
    ]
  },
  "overwrite": true
}' http://192.168.99.100:3000/api/dashboards/db

# Print out Grafana dashboard URL
echo "Grafana dashboard URL: http://192.168.99.100:3000/d/Gp6B_iwMk/docker-metrics"
