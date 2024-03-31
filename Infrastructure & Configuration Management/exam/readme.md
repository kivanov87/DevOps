#########Docker station#################### 
Ansible will install docker and terraform 
forwarding.sh will open ports for the containers

Manual Commands
vagrant up docker 
cp -R /vagrant/containers/* /home/vagrant/ 

cd/home/vagrant/apache
terraform init
echo "yes" | terraform apply
cd /home/vagrant/exporter
terraform init
echo "yes" | terraform apply
cd chome/vagrant/code
terraform init
echo "yes" | terraform apply
cd /home/vagrant/monitoring
terraform init
echo "yes" | terraform apply

docker logs kafka-consumer

docker logs kafka-producer

Login into Grafana http://192.168.99.100:3000/

Checking source, and setup dashboard with metroc for the producer.

Discovered_facts_created"

#############WEB HOST#############
vagrant up web 
Puppet will install and start app 2 and 4 from the repo https://github.com/shekeriev/do2-app-pack

ръчна команда необходима за тази машина 

sudo systemctl stop firewalld

#############DB HOST#############
vagrant up db

Puppet will install and start databases for the apps  2 and 4 

sudo systemctl stop firewalld


 