#!/bin/bash

echo "* Install Logstash"
wget https://artifacts.elastic.co/downloads/logstash/logstash-8.6.2-x86_64.rpm
sudo rpm -Uvh logstash-*.rpm
sudo cp /vagrant/jvm.logstash /etc/logstash/jvm.options


echo "* reboot services"
sudo systemctl daemon-reload
sudo systemctl enable logstash
sudo systemctl start logstash

echo "* Install kibana"
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.6.2-x86_64.rpm
sudo rpm -Uvh kibana-*.rpm

sudo cp /vagrant/kibana.yml /etc/kibana/kibana.yml
sudo systemctl enable kibana
sudo systemctl start kibana


echo "* Install logstash"
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.2-x86_64.rpm
sudo rpm -Uvh elasticsearch-*.rpm

echo "* Copying Elasticsearch Config Files"
sudo cp /vagrant/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp /vagrant/jvm.elastic /etc/elasticsearch/jvm.options.d/jvm.options


echo "* reboot services"
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

sudo firewall-cmd --reload

echo "* heartbeat install"
wget https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-8.6.2-x86_64.rpm
sudo rpm -Uvh heartbeat-8.6.2-x86_64.rpm

echo "* copy metric yml"
sudo cp /vagrant/heartbeat.yml /etc/heartbeat/heartbeat.yml

echo "* setup index"
sudo heartbeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'

echo "* copy beats.conf"
sudo cp /vagrant/beats.conf /etc/logstash/conf.d/beats.conf

echo "* restart services"
sudo systemctl restart logstash
sudo systemctl daemon-reload
sudo systemctl enable heartbeat-elastic
sudo systemctl start heartbeat-elastic