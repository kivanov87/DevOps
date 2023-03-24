#!/bin/bash

echo "* Add and import the repository key"
wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "* Update repositories and install components"
dnf install -y java-17-openjdk jenkins git

echo "* Start the service"
systemctl enable --now jenkins

echo "* Adjust the firewall"
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload

echo "* admin password is:"
cat /var/lib/jenkins/secrets/initialAdminPassword

echo "* Stop Jenkins"
systemctl stop jenkins

echo "* Turn off setup wizard"
sed -i 's/# arguments to pass to java/JAVA_OPTS="-Djenkins.install.runSetupWizard=false"/' /etc/default/jenkins

echo "* Download Jenkins Plugin Manager" 
wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.9/jenkins-plugin-manager-2.12.9.jar

echo "* Install Plugins" 
java -jar jenkins-plugin-manager-*.jar --war /usr/share/java/jenkins.war --plugin-file /vagrant/plugins.txt -d /var/lib/jenkins/plugins --verbose

echo "* Restart Jenkins" 
systemctl restart jenkins

echo "* Download Jenkins CLI"
wget http://192.168.99.100:8080/jnlpJars/jenkins-cli.jar

echo "* admin password is:"
cat /var/lib/jenkins/secrets/initialAdminPassword
