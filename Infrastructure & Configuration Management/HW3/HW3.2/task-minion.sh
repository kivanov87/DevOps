#!/bin/bash

wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

sudo sh bootstrap-salt.sh -P stable 3006.0

sudo sed -i '16s/.*/master: server/' /etc/salt/minion