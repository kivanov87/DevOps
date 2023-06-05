
echo "* Open Zookeeper ports ..."
sudo firewall-cmd --add-port 2181/tcp --permanent
echo "* Open Docker ports ..."
sudo firewall-cmd --add-port 2375/tcp --permanent
echo "* Open Grafana ports ..."
sudo firewall-cmd --add-port 3000/tcp --permanent
echo "* Open Promerheus ports ..."
sudo firewall-cmd --add-port 9090/tcp --permanent
echo "* Open Kafka ports ..."
sudo firewall-cmd --add-port 9092/tcp --permanent
echo "* Open Kafka-exporter ports ..."
sudo firewall-cmd --add-port 9308/tcp --permanent
echo "* Reload firewall settings ..."
sudo firewall-cmd --reload

echo "* Install needed softwares ..."
sudo dnf install -y python3 python3-pip python3-distro
pip3 install docker

echo "* Install terraform ..."
wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip
mv terraform /usr/local/bin

echo "* Install puppet and docker module ..."
sudo dnf install -y https://yum.puppet.com/puppet7-release-el-8.noarch.rpm
sudo dnf install -y puppet-agent

puppet module install puppetlabs-firewall --version 5.0.0

puppet module install puppetlabs-docker --version 7.0.0
