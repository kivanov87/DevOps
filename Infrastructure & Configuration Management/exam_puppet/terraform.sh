#!/bin/bash

echo "* Copy terraform folders ..."
cp -Rp /vagrant/terraform/* /home/vagrant/

echo "* Terraform init kafka ..."
cd /home/vagrant/apache
terraform init

echo "* Terraform apply kafka ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init exporter ..."
cd /home/vagrant/exporter
terraform init

echo "* Terraform apply exporter ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init app ..."
cd /home/vagrant/code
terraform init

echo "* Terraform apply app ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init monitoring ..."
cd /home/vagrant/monitoring
terraform init

echo "* Terraform apply monitoring ..."
echo "yes" | terraform apply

sleep 30s
docker logs kafka-consumer
docker logs kafka-producer