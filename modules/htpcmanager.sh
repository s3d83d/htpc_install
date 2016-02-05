#!/bin/bash

echo "Installing HTPC Manager..."

## Installing dependencies
sudo apt-get install build-essential git python-imaging python-dev python-setuptools python-pip python-cherrypy vnstat -y

sudo pip install psutil

sudo git clone https://github.com/Hellowlol/HTPC-Manager /opt/HTPCManager

## They recommend taking ownership with a user. I'm leaving root ownership for now.
#sudo chown -R user:user /opt/HTPCManager

sudo cp /opt/HTPCManager/initscripts/initd /etc/init.d/htpcmanager

sudo sed -i "s|`grep -i app_path /etc/init.d/htpcmanager | awk -F= '{print $2}'`|/opt/HTPCManager|g" /etc/init.d/htpcmanager

sudo chmod +x /etc/init.d/htpcmanager

sudo update-rc.d htpcmanager defaults

