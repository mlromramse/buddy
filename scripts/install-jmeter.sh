#!/bin/bash
echo "###################################################################"
echo "# install-jmeter.sh"

echo "# Installing softwares"
echo "## Install Apache JMeter"
cd /opt
sudo wget http://apache.mirrors.spacedump.net//jmeter/binaries/apache-jmeter-2.11.tgz
sudo tar xzvf apache-jmeter-2.11.tgz
sudo rm apache-jmeter-2.11.tgz
sudo chown admin:admin apache-jmeter-2.11
