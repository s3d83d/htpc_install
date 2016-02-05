#!/bin/bash

echo "Installing CouchPotato..."

sudo apt-get install git-core libffi-dev libssl-dev zlib1g-dev libxslt1-dev libxml2-dev python python-pip python-dev build-essential -y

sudo pip install lxml cryptography pyopenssl

sudo git clone https://github.com/RuudBurger/CouchPotatoServer /opt/couchpotato

## They recommend taking ownership with a user. I'm leaving root ownership for now.
#sudo chown -R user:user /opt/couchpotato

## They provide a default file. I'm using a pre-built for now
#sudo cp /opt/couchpotato/init/ubuntu.default /etc/default/couchpotato

sudo cp -f $current_dir/configs/couchpotato/couchpotato /etc/default/

sudo cp /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato

sudo chmod +x /etc/init.d/couchpotato

sudo update-rc.d couchpotato defaults
