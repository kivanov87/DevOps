#!/bin/bash

sudo salt-ssh -i 'docker' cmd.run 'dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo'

sudo salt-ssh -i 'docker' cmd.run 'dnf install -y docker-ce docker-ce-cli containerd.io'

sudo salt-ssh -i 'docker' cmd.run 'systemctl enable --now docker'

sudo salt-ssh -i 'docker' cmd.run 'docker run --name mynginx1 -p 80:80 -d nginx'