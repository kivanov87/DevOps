#!/bin/bash

wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.6.2-amd64.deb

sudo dpkg -i metricbeat-8.6.2-amd64.deb

sudo cp /vagrant/metric_beat.yml /etc/metricbeat/metric_beat.yml

sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat

sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.100:9200"]'

sudo ufw allow 5044/tcp


