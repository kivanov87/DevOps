#!/bin/bash

echo "* Add and import the repository key"
wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "* Update repositories and install components"
dnf install -y java-17-openjdk jenkins git

echo "* Start the service"
systemctl enable --now jenkins

echo "* Turn off setup wizard"
sed -i 's/# arguments to pass to java/JAVA_OPTS="-Djenkins.install.runSetupWizard=false"/' /etc/default/jenkins

echo "* Upload Groovy scripts"
mkdir /var/lib/jenkins/init.groovy.d
cp /vagrant/jenkins/*.groovy /var/lib/jenkins/init.groovy.d/
chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d/

echo "* Adjust the firewall"
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload

echo "* admin password is:"
cat /var/lib/jenkins/secrets/initialAdminPassword

echo "* Stop Jenkins"
systemctl stop jenkins

echo "* Download Jenkins Plugin Manager" 
wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.9/jenkins-plugin-manager-2.12.9.jar

echo "* Install Plugins" 
java -jar jenkins-plugin-manager-*.jar --war /usr/share/java/jenkins.war --plugin-file /vagrant/plugins.txt -d /var/lib/jenkins/plugins --verbose

echo "* Restart Jenkins" 
systemctl restart jenkins

echo "* Add Jenkins and adjust the group membership"
sudo useradd jenkins

echo -e 'jenkinss\njenkinss' | sudo passwd jenkins
sudo usermod -s /bin/bash jenkins

echo "jenkins  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

echo "* Download Jenkins CLI"
wget http://192.168.111.100:8080/jnlpJars/jenkins-cli.jar

echo "* Create vagrant credentials"
/vagrant/jenkins/add-jenkins-credentials.sh vagrant vagrant vagrant

echo "* Create Docker Hub credentials"
/vagrant/jenkins/add-jenkins-credentials.sh docker-hub $CRED_NAME $CRED_PASS

echo "* Add slave node"
/vagrant/jenkins/add-jenkins-slave.sh containers.do1.exam vagrant

echo "* admin password is:"
cat /var/lib/jenkins/secrets/initialAdminPassword
