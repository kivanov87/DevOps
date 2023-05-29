#!/bin/bash

sudo rpm --import https://www.rabbitmq.com/rabbitmq-release-signing-key.asc

sudo dnf install socat logrotate -y

sudo dnf install rabbitmq-server-3.11.16-1.el8.noarch.rpm -y

sudo rpm --import https://packagecloud.io/rabbitmq/erlang/gpgkey

sudo rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey


