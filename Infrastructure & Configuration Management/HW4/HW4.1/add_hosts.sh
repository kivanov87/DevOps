#!/bin/bash

echo "192.168.99.100 server" >> /etc/hosts
echo "192.168.99.101 docker" >> /etc/hosts

sudo dnf install -y chrony

sudo systemctl enable chronyd

sudo systemctl start chronyd

sudo setenforce permissive

sudo sed -i 's\=enforcing\=permissive\g' /etc/sysconfig/selinux