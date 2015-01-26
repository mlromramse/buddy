#!/bin/bash
echo "###################################################################"
echo "# install-dev-tools.sh"

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git maven

echo "# Copying settings.xml from buddy/secrets/settings.xml to admin user"
sudo mkdir /home/admin/.m2
sudo chown admin:admin /home/admin/.m2
sudo mv /home/admin/settings.xml /home/admin/.m2

if [ "$EC2_VNC_USER" == "" ];
then
	exit 0
fi

echo "# Copying settings.xml to user $EC2_VNC_USER"
sudo cp -R /home/admin/.m2/ /home/$EC2_VNC_USER/.
sudo chown $EC2_VNC_USER:$EC2_VNC_USER /home/$EC2_VNC_USER/.m2