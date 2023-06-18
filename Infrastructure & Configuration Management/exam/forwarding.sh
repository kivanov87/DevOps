#!/bin/bash

sudo firewall-cmd --add-port 9090/tcp --permanent
sudo firewall-cmd --add-port 3000/tcp --permanent
sudo firewall-cmd --add-port 9092/tcp --permanent
sudo firewall-cmd --add-port 9308/tcp --permanent
sudo firewall-cmd --add-port 2181/tcp --permanent
sudo firewall-cmd --add-port 5000/tcp --permanent
sudo firewall-cmd --add-port 8000/tcp --permanent
sudo firewall-cmd --reload