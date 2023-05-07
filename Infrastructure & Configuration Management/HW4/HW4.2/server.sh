#!/bin/bash

wget -P /tmp https://packages.chef.io/files/stable/chef-server/15.6.2/el/8/chef-server-core-15.6.2-1.el8.x86_64.rpm

sudo rpm -Uvh /tmp/chef-server-core-15.6.2-1.el8.x86_64.rpm

sudo chef-server-ctl reconfigure --chef-license accept

sudo chef-server-ctl user-create chefadmin Chef Admin chefadmin@do2.lab 'Password1' --filename /home/vagrant/chefadmin.pem

sudo chef-server-ctl org-create demo-org 'Demo Org.' --association_user chefadmin --filename /home/vagrant/demoorg-validator.pem

sudo firewall-cmd --add-port=80/tcp --permanent

sudo firewall-cmd --add-port=443/tcp --permanent

sudo firewall-cmd --reload

sudo chef-server-ctl install chef-manage

sudo chef-server-ctl reconfigure --chef-license accept

sudo chef-manage-ctl reconfigure --chef-license accept

knife bootstrap 192.168.99.102 -N web -U vagrant -P vagrant --sudo

knife bootstrap 192.168.99.103 -N db -U vagrant -P vagrant --sudo