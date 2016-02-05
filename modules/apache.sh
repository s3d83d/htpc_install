#!/bin/bash

echo "Installing Apache..."
myip=$(ifconfig | grep -e "\<inet\>" | grep -v 127.0.0.1 | awk '{print $2}' | awk -F: '{print $2}')

sudo apt-get install apache2 -y

sudo a2enmod proxy
sudo sed -i "s|`grep -i servername /etc/apache2/sites-available/default.conf | awk '{print $2}'`|${myip}|g" /etc/apache2/site-available/default.conf

sudo a2ensite default.conf

sudo service apache2 reload
