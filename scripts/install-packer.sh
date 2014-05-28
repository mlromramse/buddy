#!/bin/bash
echo "###################################################################"
echo "# install-packer.sh"

echo "# Installing softwares"
echo "## Install Packer"
cd /opt
sudo wget https://dl.bintray.com/mitchellh/packer/0.6.0_linux_amd64.zip
sudo unzip 0.6.0_linux_amd64.zip -d packer
sudo rm 0.6.0_linux_amd64.zip
sudo chown admin:admin packer

echo "# Update .bash_aliases"
echo 'export PATH="$PATH:/opt/packer"' >> /home/admin/.bash_aliases
