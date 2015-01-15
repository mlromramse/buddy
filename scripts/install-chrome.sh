#!/bin/bash
echo "###################################################################"
echo "# install-chrome.sh"

echo "# Installing softwares"
echo "## Install Google Chrome"

cd /opt
sudo wget -c wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-*.deb

sudo apt-get install -f -y
