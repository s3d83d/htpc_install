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
	for i in `ls $modules_dir`
	do
		sudo $modules_dir/$i
	done
}

function _post_config(){
    for i in couchpotato nzbget nzbdrone htpcmanager
    do
        sudo service $i stop
    done
    
    ### Sonarr Post Config ###
	sudo cp -f $current_dir/configs/sonarr/nzbdrone /etc/init.d/
    sudo cp -f $current_dir/configs/sonarr/config.xml /root/.config/NzbDrone/

    ### NZBGet Post Config ###
    sudo cp -f $current_dir/configs/nzbget/nzbget /etc/init.d/

    ### Apache Post Config ###
    sudo cp -f $current_dir/configs/apache/default.conf /etc/apache2/sites-available/    
    sudo sed -i "s|`grep -i servername /etc/apache2/sites-available/default.conf | awk '{print $2}'`|${myip}|g" /etc/apache2/sites-available/default.conf
    sudo a2ensite default.conf
    sudo service apache2 reload

    ### HTPC Manager Post Config ###
    ## This is a hack for now. I cannot find where this setting is stored, so I'm substituting the default value in the python launcher script
    sudo sed -i "s|`grep -e "--webdir" /opt/HTPCManager/Htpc.py | awk '{print $2}'`|default=\"/htpc\",|g" /opt/HTPCManager/Htpc.py

    ### Couchpotato Post Config ###
    sudo cp -f $current_dir/configs/couchpotato/couchpotato /etc/default/
    ## Set url_base for apache reverse proxy
    sudo sed -i "s|`grep url_base /opt/couchpotato/settings.conf`|url_base = movies|g" /opt/couchpotato/settings.conf
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
            sudo cp -f $current_dir/configs/apache/default.conf /etc/apache2/sites-available/
            sudo sed -i "s|`grep -i servername /etc/apache2/sites-available/default.conf | awk '{print $2}'`|${myip}|g" /etc/apache2/sites-available/default.conf
            sudo a2ensite default.conf
            sudo service apache2 reload
			break
			;;
		*)
			_usage
			exit 1
			;;
	esac
done

_post_config

sudo reboot

## Script End
