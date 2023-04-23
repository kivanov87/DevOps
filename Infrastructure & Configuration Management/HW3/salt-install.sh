#!/bin/bash

sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest/SALT-PROJECT-GPG-PUBKEY-2023.pub

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

sudo  echo "nowe" /etc/yum.repos.d/salt.repo

sudo curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo
