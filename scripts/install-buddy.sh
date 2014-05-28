#!/bin/bash
echo "###################################################################"
echo "# install-buddy.sh"

echo "# Installing softwares"
echo "## Install Git"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git

echo "## Install Buddy GitHub Project"
git clone https://github.com/mlromramse/buddy.git

