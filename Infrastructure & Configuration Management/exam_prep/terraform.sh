#!/bin/bash

sudo cp -R /vagrant/apache/* .
sudo cp -R /vagrant/exporter/* .
sudo cp -R /vagrant/monitoring/* .
sudo cp -R /vagrant/code/* .

echo "* Terraform init apache ..."
cd apache
terraform init

echo "* Terraform apply kafka ..."
echo "yes" | terraform apply

sleep 20s

echo "* Terraform init exporter ..."
cd
cd exporter
terraform init

echo "* Terraform apply exporter ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init code ..."
cd
cd code
terraform init

echo "* Terraform apply apps ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init monitoring ..."
cd
cd monitoring
terraform init

echo "* Terraform apply monitoring ..."
echo "yes" | terraform apply

sleep 30s
docker logs kafka-consumer
docker logs kafka-producer