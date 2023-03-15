#!/bin/bash

echo -e "\033[0;36mDocker Swarm Init\033[0m"
docker swarm init --advertise-addr 192.168.99.100

docker run -d -p 3000:3000 --name grafana \
-e "GF_INSTALL_PLUGINS=grafana-piechart-panel" \
-e "GF_SECURITY_ADMIN_PASSWORD=admin" \
--entrypoint="sh" \
grafana/grafana:latest \
-c "curl -XPOST -H 'Content-Type: application/json' -d @dashboard.json http://192.168.99.100:3000
echo -e "\033[0;36mStarting Prometheus as a Service in the Swarm\033[0m"
cd /vagrant
docker compose up -d

echo -e "\033[0;36mStarting 2 containers from goprom image\033[0m"
docker container run -d --name goprom1 -p 8081:8080 shekeriev/goprom
docker container run -d --name goprom2 -p 8082:8080 shekeriev/goprom

echo -e "\033[0;36mStarting runner scripts for goprom containers\033[0m"
/vagrant/goprom/runner.sh http://192.168.99.100:8081 &> /tmp/runner8081.log &
/vagrant/goprom/runner.sh http://192.168.99.100:8082 &> /tmp/runner8082.log &