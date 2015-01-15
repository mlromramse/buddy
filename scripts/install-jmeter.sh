#!/bin/bash
JMETER_VERSION="2.12"

echo "###################################################################"
echo "# install-jmeter.sh"

echo "# Installing softwares"
echo "## Install Apache JMeter $JMETER_VERSION"

cd /opt
JMETER_VERSION="2.12"
sudo wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz
sudo tar xzvf apache-jmeter-$JMETER_VERSION.tgz
sudo rm apache-jmeter-$JMETER_VERSION.tgz

sudo ln -s apache-jmeter-$JMETER_VERSION apache-jmeter
sudo chown admin:admin apache-jmeter-$JMETER_VERSION
sudo chown admin:admin apache-jmeter
