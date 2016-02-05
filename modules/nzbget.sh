#!/bin/bash

echo "Installing NZBGet..."

sudo apt-get install unrar -y

sudo apt-add-repository ppa:modriscoll/nzbget -y

sudo apt-get update

sudo apt-get install nzbget -y --force-yes

sudo cp -f /usr/share/nzbget/nzbget.conf /root/.nzbget

## They recommend taking ownership with a user. I'm leaving root ownership for now.
#sudo chown user:user ~/.nzbget

sudo chmod +x /etc/init.d/nzbget

sudo update-rc.d nzbget defaults

