#!/bin/bash
echo "###################################################################"
echo "# debian-update-upgrade.sh"

echo "# Updating and installing base softwares"
echo "## Update repositories"
sudo apt-get update -y
echo "## Upgrade the system"
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y  
echo "## Install"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y less telnet vim tree

