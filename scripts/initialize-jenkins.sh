#!/bin/bash
echo "###################################################################"
echo "# initialize-jenkins.sh"
echo "# Makes it possible to log in from jenkins master by its pub key"

if [ "$EC2_VNC_USER" == "" ];
then
EC2_VNC_USER="admin"
fi

echo "# Appending id_rsa_jenkins.pub from buddy/secrets/id_rsa_jenkins.pub"
sudo sh -c "cat /home/admin/id_rsa_jenkins.pub >> /home/$EC2_VNC_USER/.ssh/authorized_keys"
sudo rm /home/admin/id_rsa_jenkins.pub
