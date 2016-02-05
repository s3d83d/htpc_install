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
if [ -f /etc/os-release ]; then
	os_fam=`cat /etc/os-release | grep -ie "\<name\>" | awk -F"\"" '{print $2}'`
	os_ver=`lsb_release -a | grep -i release | awk '{print $2}'`
fi
current_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

## Functions
function _usage(){
	echo -e "\nsudo ${current_dir}/install.sh [ complete ] [ htpc | plex | nzbdrone | couchpotato | nzbget | apache ]\n"
}
## Fact Checking
if [ `whoami` != 'root']; then
	echo -e "\nYou must run with root privileges (i.e. sudo)"
	_usage
fi

if [ "${os_fam,,}" != 'ubuntu' ] && [ "${os_ver}" != '14.04']; then
	read -p "This script was tested on Ubuntu 14.04. Your version [${os_fam} ${os_ver}] has not been verified to work with this script. Do you wish to continue? (y/n)" y
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) 
			exit 1
		;;
		* ) echo "Plese answer y or n.";;
	esac
fi

## Script Begin
