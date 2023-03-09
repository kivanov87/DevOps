#!/bin/bash
echo "192.168.99.100 jenkins.do1.lab jenkins" >> /etc/hosts

echo "* Installing Apache ..."
sudo dnf -y install httpd

echo "* Starting Apache server ..."
sudo systemctl start httpd
sudo systemctl enable httpd

echo "* Adding Jenkins user to sudoers..."
sudo sed -i '/^root\s\+ALL=(ALL)\s\+ALL/a jenkins ALL=(ALL) NOPASSWD: AL' /etc/sudoers

echo -e "\e[32m$initialAdminPassword\e[0m"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword | echo -e "\e[32m$(cat)\e[0m"