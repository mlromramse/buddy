#!/bin/bash
echo "###################################################################"
echo "# initialize-vnc.sh"

# Here passwords for the vnc access is set. 
# Normal login is 'password' and read only is 'guest'.
# Change this to your liking
printf "password\nguest\n" | tightvncpasswd -f > /home/admin/.vnc/passwd
chmod 400 /home/admin/.vnc/passwd

# Make sure the panels will show up
mkdir -p /home/admin/.config/lxpanel/LXDE/panels
sudo cp -r /usr/share/lxpanel/profile/default/panels/* /home/admin/.config/lxpanel/LXDE/panels/.

# Active autostart and service script of tightvncserver
sudo update-rc.d tightvncserver defaults

