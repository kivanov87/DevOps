#!/bin/bash

echo *INSTALL ANSIBLE CORE *
dnf install ansible-core -y
echo *INSTALL ANSIBLE-GALAXY *
ansible-galaxy collection install -p /usr/share/ansible/collections ansible.posix
ansible-galaxy collection install community.docker

echo *COPY INVENTORY AND CFG FILES*
cp /vagrant/HW2.1/inventory .
cp /vagrant/HW2.1/ansible.cfg .
cp /vagrant/HW2.1/playbook.yml .

echo *Start playbook*
ansible-playbook playbook.yml