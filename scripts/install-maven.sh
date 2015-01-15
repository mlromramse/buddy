#!/bin/bash
echo "###################################################################"
echo "# install-maven.sh"

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y maven

echo "# Copying settings.xml from buddy/secrets/settings.xml to admin user"
sudo mv /home/admin/settings.xml /home/admin/.m2

if [ "$EC2_VNC_USER" == "" ];
then
	exit 0
fi

echo "# Copying settings.xml to user $EC2_VNC_USER"
sudo cp -R /home/admin/.m2/ /home/$EC2_VNC_USER/.