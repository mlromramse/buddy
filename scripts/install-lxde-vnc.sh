#!/bin/bash
echo "###################################################################"
echo "# install-lxde-vnc.sh"

echo "# Installing softwares"
echo "## Install lxde xorg and tightvncserver"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y lxde xorg tightvncserver

echo "# Disable screensaver"
sudo sed -i '/@xscreensave/d' /etc/xdg/lxsession/LXDE/autostart

echo "# Move autostart script to /etc/init.d"
sudo mv tightvncserver /etc/init.d/.
sudo chown root:root /etc/init.d/tightvncserver
sudo chmod +x /etc/init.d/tightvncserver
if [ "$EC2_VNC_USER" != "" ];
then
	sudo chmod +x /home/$EC2_VNC_USER/.vnc/xstartup
else
	sudo chmod +x /home/admin/.vnc/xstartup
fi
