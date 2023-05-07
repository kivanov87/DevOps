#!/bin/bash

sudo apt-get install -y ntp

wget -P /tmp https://packages.chef.io/files/stable/chef-workstation/23.4.1032/el/8/chef-workstation-23.4.1032-1.el8.x86_64.rpm

sudo rpm -Uvh /tmp/chef-workstation-23.4.1032-1.el8.x86_64.rpm

sudo dnf install -y git

echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

echo 'export PATH="/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

cd chef-repo

knife ssl fetch