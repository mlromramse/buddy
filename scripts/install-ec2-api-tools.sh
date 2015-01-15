#!/bin/bash
echo "###################################################################"
echo "# install-ec2-api-tools.sh"

echo "# Installing softwares"
echo "## Install Amazon EC2 API TOOLS"
cd /opt
sudo wget -O ec2-api-tools.zip 'http://www.amazon.com/gp/redirect.html/ref=aws_rc_ec2tools?location=http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip&token=A80325AA4DAB186C80828ED5138633E3F49160D9'
sudo unzip ec2-api-tools.zip
sudo rm ec2-api-tools.zip
sudo ln -s ec2-api-tools* ec2-api-tools
sudo chown admin:admin ec2-api-tools*

echo "# Update .bash_aliases"
echo 'export EC2_HOME="/opt/ec2-api-tools"' >> /home/admin/.bash_aliases
echo 'export AMI_ID_SLAVE="ENTER_YOUR_AMI_ID_FOR_YOUR_SLAVE_IMAGE_HERE"' >> /home/admin/.bash_aliases
echo 'export AMI_ZONE="ENTER_YOUR_PREFERRED_ZONE_HERE"' >> /home/admin/.bash_aliases
echo 'export AWS_ACCESS_KEY="ENTER_YOUR_AWS_ACCESS_KEY_HERE"' >> /home/admin/.bash_aliases
echo 'export AWS_SECRET_KEY="ENTER_YOUR_AWS_SECRET_KEY_HERE"' >> /home/admin/.bash_aliases
# Remember to run 'source ~/.bash_aliases' when you are done.
echo 'export EC2_URL="https://ec2.eu-west-1.amazonaws.com"' >> /home/admin/.bash_aliases
echo 'export PATH="$PATH:$EC2_HOME/bin"' >> /home/admin/.bash_aliases
echo 'export SECURITY_GROUP_SLAVE="ENTER_YOUR_PREFERRED_SECURITY_GROUP_HERE"' >> /home/admin/.bash_aliases

echo "'# Remember to run 'source ~/.bash_aliases' when you are done." >> /home/admin/.bash_aliases

