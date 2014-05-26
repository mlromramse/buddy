#!/bin/bash
echo "###################################################################"
echo "# install-lxde-vnc.sh"

echo "# Installing softwares"
echo "## Install lxde xorg and tightvncserver"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y lxde xorg tightvncserver

export DISPLAY="localhost:1"

echo "# Move autostart script to /etc/init.d"
sudo mv tightvncserver /etc/init.d/.
sudo chown root:root /etc/init.d/tightvncserver
sudo chmod +x /etc/init.d/tightvncserver
sudo chmod +x /home/admin/.vnc/xstartup
