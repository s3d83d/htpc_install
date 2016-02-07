#!/bin/bash

## Variables
if [ -f /etc/os-release ]; then
	os_fam=`cat /etc/os-release | grep -ie "\<name\>" | awk -F"\"" '{print $2}'`
	os_ver=`cat /etc/os-release | grep -ie "\<version\>" | awk -F"\"" '{print $2}' | awk '{print $1}'`
fi
export current_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

## Source all of the handlers
for i in `ls handlers`
do
	. handlers/$i
done

### Fact Checking ###
_verify_root

_verify_os

### Script Begin ###
params="$(getopt -o Ahpscna -l all,htpc,plex,sonarr,couchpotato,nzbget,apache --name "$0" -- "$@")"
eval set -- "$params"

while true
do
	case "$1" in
		-A|--all)
			_install_all
			break
			;;
		-h|--htpc)
			_htpc_install
			#_htpc_postconfig
			break
			;;
		-p|--plex)
			_plex_install
			break
			;;
		-s|--sonarr)
			_sonarr_install
			_sonarr_postconfig
			break
			;;
		-c|--couchpotato)
            _couchpotato_install
            _couchpotato_postconfig
			break
			;;
		-n|--nzbget)
            _nzbget_install
            _nzbget_postconfig
			break
			;;
		-a|--apache)
			_apache_install
			_apache_postconfig
			break
			;;
		*)
			_usage
			exit 1
			;;
	esac
done

#_post_config

#sudo reboot

### Script End ###
