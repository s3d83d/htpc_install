#!/bin/bash

## Variables
if [ -f /etc/os-release ]; then
	os_fam=`cat /etc/os-release | grep -ie "\<name\>" | awk -F"\"" '{print $2}'`
	os_ver=`cat /etc/os-release | grep -ie "\<version\>" | awk -F"\"" '{print $2}' | awk '{print $1}'`
fi
export current_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
export modules_dir=$current_dir/modules

## Functions
function _usage(){
	echo -e "\nsudo ${current_dir}/install.sh [ -A --all ] [ -h --htpc | -p --plex | -s --sonarr | -c --couchpotato | -n --nzbget | -a --apache ]\n"
	exit 1
}

function _run_all(){
    sudo mkdir -p /etc/apache2/sites-available
	sudo cp -f $current_dir/configs/sonarr/nzbdrone /etc/init.d/
    sudo cp -f $current_dir/configs/nzbget/nzbget /etc/init.d/
    sudo cp -f $current_dir/configs/apache/default.conf /etc/apache2/sites-available/
    sudo cp -f $current_dir/configs/couchpotato/couchpotato /etc/default/
	for i in `ls $modules_dir`
	do
		sudo $modules_dir/$i
	done
    sudo cp -f $current_dir/configs/sonarr/config.xml /root/.config/NzbDrone/
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
			sudo cp -f $current_dir/configs/sonarr/nzbdrone /etc/init.d/
			sudo $modules_dir/sonarr.sh
            sudo cp -f $current_dir/configs/sonarr/config.xml /root/.config/NzbDrone/
			break
			;;
		-c|--couchpotato)
			sudo cp -f $current_dir/configs/couchpotato/couchpotato /etc/default/
			sudo $modules_dir/couchpotato.sh
			break
			;;
		-n|--nzbget)
            sudo cp -f $current_dir/configs/nzbget/nzbget /etc/init.d/
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

sudo reboot

## Script End
