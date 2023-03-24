#!/bin/bash

echo "* Adjust the firewall"
firewall-cmd --permanent --add-port=3000/tcp
firewall-cmd --reload

# Start Gitea
docker compose -f /vagrant/provision_scripts/docker/docker-compose.yml up -d

# Wait until ready
while true; do 
  echo 'Trying to connect to http://192.168.99.101:3000 ...'; 
  if [ $(curl -s -o /dev/null -w "%{http_code}" http://192.168.99.101:3000) == "200" ]; then 
    echo '... connected.'; 
    break; 
  else 
    echo '... no success. Sleep for 5s and retry.'; 
    sleep 5; 
  fi 
done

# Add user
docker container exec -u 1000 gitea gitea admin user create --username vagrant --password vagrant --email vagrant@do1.lab

# Clone the project
git clone https://github.com/shekeriev/dob-2021-04-exam-re  /tmp/dob-2021-04-exam-re


# Add a Webhook
curl -X 'POST' 'http://192.168.99.101:3000/api/v1/repos/vagrant/dob-2021-04-exam-re/hooks' \
  -H 'accept: application/json' \
  -H 'authorization: Basic '$(echo -n 'vagrant:vagrant' | base64) \
  -H 'Content-Type: application/json' \
  -d '{
  "active": true,
  "branch_filter": "*",
  "config": {
    "content_type": "json",
    "url": "http://192.168.99.100:8080/gitea-webhook/post",
    "http_method": "post"
  },
  "events": [
    "push"
  ],
  "type": "gitea"
}'
