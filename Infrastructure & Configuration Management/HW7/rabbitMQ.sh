#!/bin/bash

sudo update-crypto-policies --set LEGACY

sudo rpm --import https://github.com/rabbitmq/signingkeys/releases/download/2.0/rabbitmq-release-signing-key.asc

sudo rpm --import https://packagecloud.io/rabbitmq/erlang/gpgkey

sudo rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey


