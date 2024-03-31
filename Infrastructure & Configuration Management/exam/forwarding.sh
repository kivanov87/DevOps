#!/bin/bash

sudo firewall-cmd --add-port 9090/tcp --permanent
sudo firewall-cmd --add-port 3000/tcp --permanent
sudo firewall-cmd --add-port 9092/tcp --permanent
sudo firewall-cmd --add-port 9308/tcp --permanent
sudo firewall-cmd --add-port 2181/tcp --permanent
sudo firewall-cmd --add-port 5000/tcp --permanent
sudo firewall-cmd --add-port 8000/tcp --permanent
sudo firewall-cmd --reload

echo " Adding EPEL repository ..."
dnf install -y epel-release

echo " Installing Python3 ..."
dnf install -y python3 python3-pip

echo " Installing Python Docker module ..."
pip3 install docker