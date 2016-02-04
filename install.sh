#!/bin/bash

# Install HTPC Server with the following applications:
#
#    1. HTPC Manager
#    2. Plex
#    3. NZBDrone/Sonarr
#    4. CouchPotato
#    5. NZBGet
#    6. Apache
# 

## Variables
os_ver=`lsb_release -a | grep -i release | awk '{print $2}'`

## Fact Checking
if [ "${os_ver}" != '14.04']; then
	read -p "This script was tested on Ubuntu 14.04. Your version [${os_ver}] has not been verified to work with this script. Do you wish to continue? (y/n)" y
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) 
			exit 1
		;;
		* ) echo "Plese answer y or n.";;
	esac
fi

## Script Begin
