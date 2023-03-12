#!/bin/bash

# Start Docker daemon with metrics enabled
dockerd --metrics-addr="localhost:9323" &

# Wait for Docker daemon to start up
sleep 5

# Add Docker job configuration to Prometheus
cat << EOF > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
- job_name: 'docker'
  static_configs:
  - targets: ['localhost:9323']
  metric_relabel_configs:
  - source_labels: [instance]
    target_label: instance_name
    replacement: '$1'
    regex: '(.*):.*'
- job_name: 'goprom'
  static_configs:
  - targets: ['localhost:8081', 'localhost:8082']
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
}' http://localhost:3000/api/dashboards/db

# Print out Grafana dashboard URL
echo "Grafana dashboard URL: http://localhost:3000/d/Gp6B_iwMk/docker-metrics"
