#!/bin/bash
echo "###################################################################"
echo "# initialize-vnc.sh"
echo "# Current user is: `whoami`"

if [ "$EC2_VNC_USER" == "" ];
then
EC2_VNC_USER="admin"
else
	echo "# VNC user will be $EC2_VNC_USER"
fi

echo "# Adding environment variable EC2_VNC_USER to tightvncserver script."
echo "EC2_VNC_USER=$EC2_VNC_USER" >> EC2_VNC_USER
sudo sh -c 'cat EC2_VNC_USER > /etc/default/tightvncserver'

# Here passwords for the vnc access is set. 
# Normal login is 'password' and read only is 'guest'.
# Change this to your liking
echo "# Setting up passwords for VNC user"
sudo sh -c "printf 'password\nguest\n' | tightvncpasswd -f > /home/$EC2_VNC_USER/.vnc/passwd"
sudo chmod 400 /home/$EC2_VNC_USER/.vnc/passwd
sudo chown $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.vnc/passwd

echo "# Make sure the LXDE panels will show up for this user"
sudo mkdir -p /home/$EC2_VNC_USER/.config/lxpanel/LXDE/panels
#sudo chown $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.config/lxpanel/LXDE/panels
sudo chown -R $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.config
sudo cp -r /usr/share/lxpanel/profile/default/panels/* /home/$EC2_VNC_USER/.config/lxpanel/LXDE/panels/.

echo "# Activate autostart and service script of tightvncserver"
sudo update-rc.d tightvncserver defaults

