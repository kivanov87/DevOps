#########Docker station #################### 
ансибъл инсталира докер и тераформ
forwarding.sh отваря портовете за контейнерите

Команди:
стартираме всяка част от тераформ компонентите
vagrant up docker 
cp -R /vagrant/containers/* /home/vagrant/ копират се терраформ файловете.

cd/home/vagrant/apache
terraform init
echo "yes" | terraform apply
cd /home/vagrant/exporter
terraform init
echo "yes" | terraform apply
cd chome/vagrant/code
terraform init
echo "yes" | terraform apply
cd /home/vagrant/monitoring
terraform init
echo "yes" | terraform apply

docker logs kafka-consumer

docker logs kafka-producer

логваме в графана http://192.168.99.100:3000/

проверяваме source-a

и настройваме табло със метрика от producer-а

Discovered_facts_created"



#############машина WEB#############
vagrant up web 
пъпет инсталира и стартира web часта от приложение 2 и 4 от https://github.com/shekeriev/do2-app-pack

ръчна команда необходима за тази машина 

sudo systemctl stop firewalld

не успях да я спра с манифеста

#############машина DB#############
vagrant up db

пъпет инсталира и стартира базите от двете приложения 2 и 4

няма ръчни команди


 