#!/bin/bash
if [ "$EC2_VNC_USER" == "" ];
then
	exit 0
fi

echo "Setting up the $EC2_VNC_USER user .ssh directory"
sudo -u $EC2_VNC_USER mkdir /home/$EC2_VNC_USER/.ssh

echo "Generating the ssh keypair and add it to agent"
ssh-keygen -f id_rsa -t rsa -N ''
eval `ssh-agent -s`
ssh-add id_rsa

echo "move the keys to the correct place in the jenkins root"
sudo mv id_rsa* /home/$EC2_VNC_USER/.ssh
sudo chown -R $EC2_VNC_USER:$EC2_VNC_USER -R /home/$EC2_VNC_USER/.ssh

echo "admin autorized keys"
sudo cat /home/admin/.ssh/authorized_keys
