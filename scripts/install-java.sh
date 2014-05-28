#!/bin/bash
echo "###################################################################"
echo "# install-java.sh"

echo "# Installing softwares"
echo "## Install Java 7 runtime"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre

echo "## Setup .bash_aliases"
echo 'export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"' >> /home/admin/.bash_aliases
echo 'export DISPLAY="127.0.0.1:1"' >> /home/admin/.bash_aliases