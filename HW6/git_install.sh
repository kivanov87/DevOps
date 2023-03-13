#!/bin/bash

echo -e "\033[0;36mINSTALL GIT\033[0m"
yum install -y git 

echo -e "\033[0;36mGIT CLONE\033[0m"

git clone https://github.com/kivanov87/Prometheus.git

cd Prometheus

docker-compose build

docker compose up -d
