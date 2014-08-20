#!/bin/bash
echo "###################################################################"
echo "# initialize-jmeter-server.sh"

# Active autostart and service script of tightvncserver
sudo update-rc.d /opt/apache-jmeter-2.11/bin/jmeter-server defaults

