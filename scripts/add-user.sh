# add user $1
if [ "$EC2_VNC_USER" == "" ];
then
	exit 0
fi

echo "Adding user '$EC2_VNC_USER'."

sudo useradd -b /home -G sudo -s /bin/bash -m -U $EC2_VNC_USER
sudo sh -c "echo $EC2_VNC_USER:$EC2_VNC_USER | chpasswd"

sudo cp /home/admin/.bash* /home/$EC2_VNC_USER/.
sudo cp -r /home/admin/.vnc /home/$EC2_VNC_USER/.
sudo cp -r /home/admin/.ssh /home/$EC2_VNC_USER/.

sudo chown $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.bash*
sudo chown -R $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.vnc
sudo chown -R $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.ssh

