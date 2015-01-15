#!/bin/bash
echo "###################################################################"
echo "# install-firefox.sh"

echo "# Installing softwares"
echo "## Install Mozilla Firefox"
cd /opt
sudo rm -rf firefox*
sudo wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/34.0.5/linux-x86_64/sv-SE/firefox-34.0.5.tar.bz2
sudo tar xjvf firefox-*.tar.bz2
sudo rm firefox-*.tar.bz2
sudo chown -R admin:admin firefox*
sudo ln -sf /opt/firefox/firefox /usr/bin/firefox
