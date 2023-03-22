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

sudo cp /vagrant/kibana.yml /etc/logstash/kibana.yml

echo "* Install logstash"
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.6.2-x86_64.rpm
sudo rpm -Uvh elasticsearch-*.rpm

echo "* Copying Elasticsearch Config Files"
sudo sudo rm /etc/elasticsearch/elasticsearch.yml -f
sudo cp /vagrant/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo cp /vagrant/jvm.elastic /etc/elasticsearch/jvm.options.d/jvm.options


echo "* reboot services"
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
