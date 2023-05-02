#!/bin/bash

sudo dnf install -y chrony

sudo systemctl enable chronyd

sudo systemctl start chronyd

sudo setenforce permissive

sudo sed -i 's\=enforcing\=permissive\g' /etc/sysconfig/selinux

wget -P /tmp https://packages.chef.io/files/stable/chef-server/15.6.2/el/8/chef-server-core-15.6.2-1.el8.x86_64.rpm

sudo rpm -Uvh /tmp/chef-server-core-15.6.2-1.el8.x86_64.rpm

sudo chef-server-ctl reconfigure --chef-license=accept

sudo chef-server-ctl user-create chefadmin Chef Admin chefadmin@do2.lab 'Password1' --filename /home/vagrant/chefadmin.pem

sudo chef-server-ctl org-create demo-org 'Demo Org.' --association_user chefadmin --filename /home/vagrant/demoorg-validator.pem

sudo firewall-cmd --add-port=80/tcp --permanent

sudo firewall-cmd --add-port=443/tcp --permanent

sudo firewall-cmd --reload

curl https://packages.chef.io/files/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip | gunzip - > chef-automate && chmod +x chef-automate

sudo ./chef-automate init-config

sudo sed -i '/^\[elasticsearch.v1.sys.runtime\]$/,/^\[/ s/^heapsize.*$/heapsize = "2g"/' config.toml

sudo sed -i '/^vm.dirty_expire_centisecs/d' /etc/sysctl.conf && echo 'vm.dirty_expire_centisecs=20000' | sudo tee -a /etc/sysctl.conf

sudo sysctl -w vm.dirty_expire_centisecs=20000

scp chefadmin.pem vagrant@workstation:/home/vagrant/.chef/chefadmin.pem






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