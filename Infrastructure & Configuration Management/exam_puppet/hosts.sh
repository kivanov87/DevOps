#!/bin/bash

echo "* Update the system ..."
sudo dnf update && sudo dnf upgrade -y
sudo dnf install -y ca-certificates.noarch curl gnupg2 tar bzip2 wget java-17-openjdk git tree chrony unzip