#!/bin/bash

echo "Installing Sonarr..."

sudo apt-get install apt-transport-https -y

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb https://apt.sonarr.tv/ master main" | sudo tee -a /etc/apt/sources.list.d/sonarr.list

sudo apt-get update
sudo apt-get install nzbdrone -y

sudo rm /etc/apt/sources.list.d/sonarr.list

sudo chmod +x /etc/init.d/nzbdrone

sudo update-rc.d nzbdrone defaults
