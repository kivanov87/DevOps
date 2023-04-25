#!/bin/bash

sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest/SALT-PROJECT-GPG-PUBKEY-2023.pub

curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

sudo sh bootstrap-salt.sh -P -M -N -X stable 3006.0
sudo dnf install salt-ssh -y
sudo firewall-cmd --permanent --add-port=4505-4506/tcp
sudo firewall-cmd --reload

sudo systemctl enable salt-master

sudo systemctl start salt-master

sudo bash -c "echo '
web:
  host: 192.168.99.102
  user: vagrant
  passwd: vagrant
  sudo: True

db:
  host: 192.168.99.103
  user: vagrant
  passwd: vagrant
  sudo: True' >> /etc/salt/roster"

  sudo salt-key -A