#!/bin/bash

echo *INSTALL ANSIBLE CORE *
dnf install ansible-core -y
echo *INSTALL ANSIBLE-GALAXY *
ansible-galaxy collection install -p /usr/share/ansible/collections ansible.posix

echo *COPY INVENTORY AND CFG FILES*
cp /vagrant/files/inventory .
cp /vagrant/files/ansible.cfg .
cp /vagrant/files/playbook.yml .

echo *Start playbook*
ansible-playbook playbook.yml