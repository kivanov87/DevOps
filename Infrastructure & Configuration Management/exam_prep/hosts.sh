#!/bin/bash

#echo "* Add hosts ..."
#echo "192.168.11.101 server.do2.lab server" | sudo tee /etc/hosts

sudo firewall-cmd --add-port 9090/tcp --permanent
sudo firewall-cmd --add-port 3000/tcp --permanent
sudo firewall-cmd --add-port 9092/tcp --permanent
sudo firewall-cmd --add-port 9308/tcp --permanent
sudo firewall-cmd --add-port 2181/tcp --permanent
sudo firewall-cmd --add-port 2375/tcp --permanent
sudo firewall-cmd --reload