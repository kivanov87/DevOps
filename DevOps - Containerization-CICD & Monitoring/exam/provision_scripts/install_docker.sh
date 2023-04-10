#!/bin/bash
echo -e "\033[0;36Add Docker repository\033[0m"
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

echo -e "\033[0;36mInstall Docker\033[0m"
dnf install -y java-17-openjdk git docker-ce docker-ce-cli containerd.io

echo -e "\033[0;36mStart Docker service\033[0m"
systemctl enable --now docker
sudo systemctl start docker


echo -e "\033[0;36mAdjust group membership\033[0m"
usermod -aG docker vagrant
usermod -aG wheel vagrant

echo "* Adjust the group membership"
usermod -aG docker vagrant

echo "* Download Jenkins CLI"
wget http://192.168.111.100:8080/jnlpJars/jenkins-cli.jar

echo "* Add Jenkins and adjust the group membership"
sudo useradd jenkins

echo -e 'jenkinss\njenkinss' | sudo passwd jenkins
sudo usermod -s /bin/bash jenkins
echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

echo "* Copying daemon.json to /etc/docker/"
sudo cp /vagrant/daemon.json /etc/docker/daemon.json

echo "* Restarting docker to detect changes in daemon.json"
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "* Adjust the firewall"
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --permanent --add-port=9100/tcp
firewall-cmd --permanent --add-port=9323/tcp
firewall-cmd --reload