vagrant up

<!-- Creating the Vagrantbox with Docker, Jenkins, Apache and Git -->

vagrant ssh jenkins

sudo wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

sudo dnf makecache

sudo dnf -y install jenkins

sudo dnf -y install java-17-openjdk

sudo systemctl start jenkins

sudo systemctl enable jenkins

echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

sudo firewall-cmd --permanent --add-port=8080/tcp

sudo firewall-cmd --permanent --add-port=80/tcp

sudo firewall-cmd --reload

sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo dnf install -y docker-ce docker-ce-cli containerd.io

sudo systemctl enable docker

sudo systemctl start docker

sudo usermod -aG docker vagrant

sudo usermod -aG docker jenkins

sudo dnf -y install git

sudo mkdir -p /projects

sudo chown -R jenkins:jenkins /projects

sudo dnf -y install httpd

sudo systemctl start httpd

sudo systemctl enable httpd

sudo sed -i '/^root\s\+ALL=(ALL)\s\+ALL/a jenkins ALL=(ALL) NOPASSWD: AL' /etc/sudoers

sudo cat /var/lib/jenkins/secrets/initialAdminPassword | echo -e "\e[32m$(cat)\e[0m"
----------------------------------------------------------------------
Open browser and put addres 127.0.0.1:8080 on the Host machine

Copy last green output and paste as jenkins secret

Install Suggested Plugins

Register as doadmin

Confirm or change URL
----------------------------------------------------------------------
open vagrant console 

sudo -u jenkins ssh-keygen -t ecdsa -b 521 -m PEM 

sudo sed -i '/jenkins/s|/bin/false|/bin/bash|' /etc/passwd

add user credentials with the key of jenkins user

Create Pipeline Dir

Create Pipeline using the Jenkinsfile script

Build now




