#!/bin/bash

wget https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.6.2-x86_64.rpm

sudo rpm -Uvh metricbeat-8.6.2-x86_64.rpm

sudo cp /vagrant/metric_beat.yml /etc/metricbeat/metric_beat.yml

sudo systemctl daemon-reload
sudo systemctl enable metricbeat
sudo systemctl start metricbeat

sudo metricbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.99.100:9200"]'

sudo firewall-cmd --add-port 5044/tcp --permanent

sudo firewall-cmd --reload