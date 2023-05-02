#!/bin/bash

# Define color variables
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Download and install chef-workstation
wget -P /tmp wget https://packages.chef.io/files/stable/chef-workstation/21.10.640/el/8/chef-workstation-21.10.640-1.el8.x86_64.rpm 

sudo rpm -Uvh /tmp/chef-workstation-21.10.640-1.el8.x86_64.rpm 


# Install git and configure git user
echo -e "${GREEN}Installing git and configuring git user...${NC}"
sudo dnf install -y git && \
git config --global user.email "Kalin.at.ivanov@gmail.com" && \
git config --global user.name "Kalin Ivanov" && \
echo -e "${GREEN}Git successfully installed and configured.${NC}"

# Configure shell to use chef-workstation

echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile 

echo 'export PATH="/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.bash_profile &&
source ~/.bash_profile 

# Download Docker cookbook
echo -e "${GREEN}Downloading Docker cookbook...${NC}"
knife supermarket download docker && \
tar xzvf docker-10.4.8.tar.gz && \
echo -e "${GREEN}Docker cookbook downloaded.${NC}"


# Create cookbook and copy files

mkdir cookbooks && cd cookbooks 
chef generate cookbook docker --chef-license=accept 
sudo cp -R /vagrant/files/default.rb  /home/vagrant/cookbooks/docker/recipes/ 
sudo cp -R /vagrant/files/solo*  /home/vagrant/cookbooks/docker
sudo cp -R /vagrant/files/metadata.rb  /home/vagrant/cookbooks/docker/metadata.rb















#wget -P /tmp https://packages.chef.io/files/stable/chef-server/15.6.2/el/8/chef-server-core-15.6.2-1.el8.x86_64.rpm

#sudo rpm -Uvh /tmp/chef-server-core-15.6.2-1.el8.x86_64.rpm

#echo "yes" | sudo chef-server-ctl reconfigure --accept-license

#sudo chef-server-ctl user-create chefadmin Chef Admin chefadmin@do2.lab 'Password1' --
#filename /home/vagrant/chefadmin.pem

#sudo chef-server-ctl org-create Nginx 'Nginx.' --association_user chefadmin --
#filename /home/vagrant/demoorg-validator.pem

#sudo firewall-cmd --add-port=80/tcp --permanent
#sudo firewall-cmd --add-port=443/tcp --permanent
#sudo firewall-cmd --reload