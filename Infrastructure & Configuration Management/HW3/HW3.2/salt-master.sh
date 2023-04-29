#!/bin/bash

set -x

# Define ANSI color escape codes
GREEN='\033[0;32m'
NC='\033[0m'

sudo rpm --import https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest/SALT-PROJECT-GPG-PUBKEY-2023.pub && \
    echo -e "${GREEN}RPM key imported successfully${NC}" || \
    echo -e "${RED}Failed to import RPM key${NC}"

curl -fsSL https://repo.saltproject.io/salt/py3/redhat/9/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo && \
    echo -e "${GREEN}Salt repository added successfully${NC}" || \
    echo -e "${RED}Failed to add Salt repository${NC}"

wget -O bootstrap-salt.sh https://bootstrap.saltstack.com && \
    echo -e "${GREEN}Salt bootstrap script downloaded successfully${NC}" || \
    echo -e "${RED}Failed to download Salt bootstrap script${NC}"

sudo sh bootstrap-salt.sh -P -M -N -X stable 3006.0 && \
    echo -e "${GREEN}Salt installed successfully${NC}" || \
    echo -e "${RED}Failed to install Salt${NC}"

sudo dnf install salt-ssh -y && \
    echo -e "${GREEN}Salt-SSH installed successfully${NC}" || \
    echo -e "${RED}Failed to install Salt-SSH${NC}"

sudo firewall-cmd --permanent --add-port=4505-4506/tcp && \
    echo -e "${GREEN}Firewall ports added successfully${NC}" || \
    echo -e "${RED}Failed to add firewall ports${NC}"

sudo firewall-cmd --reload && \
    echo -e "${GREEN}Firewall reloaded successfully${NC}" || \
    echo -e "${RED}Failed to reload firewall${NC}"

sudo systemctl enable salt-master && \
    echo -e "${GREEN}Salt-Master enabled successfully${NC}" || \
    echo -e "${RED}Failed to enable Salt-Master${NC}"

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
  sudo: True' >> /etc/salt/roster" && \
    echo -e "${GREEN}Roster updated successfully${NC}" || \
    echo -e "${RED}Failed to update roster${NC}"

sudo systemctl start salt-master && \
    echo -e "${GREEN}Salt-Master started successfully${NC}" || \
    echo -e "${RED}Failed to start Salt-Master${NC}"

sudo salt-key -A -y && \
    echo -e "${GREEN}Salt keys accepted successfully${NC}" || \
    echo -e "${RED}Failed to accept Salt keys${NC}"

sudo mkdir /srv/salt && \
    echo -e "${GREEN}/srv/salt directory created successfully${NC}" || \
    echo -e "${RED}Failed to create /srv/salt directory${NC}"

sudo cp -R /vagrant/./* /srv/salt/ && \
    echo -e "${GREEN}Files copy successfully${NC}" || \
    echo -e "${RED}Failed to copy filess${NC}"

sudo bash -c "echo '
base:
  'web.do2.lab':
    - web
  'db.do2.lab':
    - db' >> /etc/salt/top.sls"

sudo salt-key -L

sudo salt-key -A -y

sudo systemctl restart salt-master

sudo salt '*' state.apply
