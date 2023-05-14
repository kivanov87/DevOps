#!/usr/bin/env bash

# Update the package manager and install Java 17
sudo yum update -y
sudo dnf install java-17-openjdk -y
sudo systemctl disable --now firewalld

# Download and extract Kafka 3.3.1
wget https://archive.apache.org/dist/kafka/3.3.1/kafka_2.13-3.3.1.tgz -o kafka.tgz
tar xzvf kafka_2.13-3.3.1.tgz
rm kafka_2.13-3.3.1.tgz
mv kafka_2.13-3.3.1 kafka

# clear localhosts address
sudo sed -i '/^127\.0\.0\.1/d;/^::1/d' /etc/hosts

# Start Kafka
cd kafka
nohup bin/zookeeper-server-start.sh config/zookeeper.properties > /dev/null 2>&1 &
nohup bin/kafka-server-start.sh config/server.properties > /dev/null 2>&1 &

# Adjust producer to send custom messages to topic
#

# Adjust consumer to subscribe to topic
#bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic my-topic --from-beginning