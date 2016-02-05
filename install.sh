#!/bin/bash

# Install HTPC Server with the following applications:
#
#    1. HTPC Manager
#    2. Plex
#    3. Sonarr/NZBDrone
#    4. CouchPotato
#    5. NZBGet
#    6. Apache
# 

## Variables
if [ -f /etc/os-release ]; then
	os_fam=`cat /etc/os-release | grep -ie "\<name\>" | awk -F"\"" '{print $2}'`
	os_ver=`cat /etc/os-release | grep -ie "\<version\>" | awk -F"\"" '{print $2}' | awk '{print $1}'`
fi
current_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
modules_dir=$current_dir/modules

## Functions
function _usage(){
	echo -e "\nsudo ${current_dir}/install.sh [ -A --all ] [ -h --htpc | -p --plex | -s --sonarr | -c --couchpotato | -n --nzbget | -a --apache ]\n"
	exit 1
}

function _run_all(){
	for i in `ls $modules_dir`
	do
		sudo $modules_dir/$i
	done
}

## Fact Checking
if [ `whoami` != 'root' ]; then
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
params="$(getopt -o Ahpscna -l all,htpc,plex,sonarr,couchpotato,nzbget,apache --name "$0" -- "$@")"
eval set -- "$params"

while true
do
	case "$1" in
		-A|--all)
			_run_all
			break
			;;
		-h|--htpc)
			sudo $modules_dir/htpcmanager.sh
			break
			;;
		-p|--plex)
			sudo $modules_dir/plex.sh
			break
			;;
		-s|--sonarr)
			sudo $modules_dir/sonarr.sh
			break
			;;
		-c|--couchpotato)
			sudo $modules_dir/couchpotato.sh
			break
			;;
		-n|--nzbget)
			sudo $modules_dir/nzbget.sh
			break
			;;
		-a|--apache)
			sudo $modules_dir/apache.sh
			break
			;;
		*)
			_usage
			exit 1
			;;
	esac
done

## Script End