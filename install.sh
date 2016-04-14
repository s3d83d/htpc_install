#!/bin/bash
# hello john
## Variables
if [ -f /etc/os-release ]; then
	os_fam=`cat /etc/os-release | grep -ie "\<name\>" | awk -F"\"" '{print $2}'`
	os_ver=`cat /etc/os-release | grep -ie "\<version\>" | awk -F"\"" '{print $2}' | awk '{print $1}'`
fi
export current_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

declare -a apps
apps=()

## Source all of the handlers
for i in `ls handlers`
do
	. handlers/$i
done

### Fact Checking ###
_verify_root

_verify_os

### Script Begin ###
params="$(getopt -o AhpsScnNa -l all,htpc,plex,sonarr,sickrage,couchpotato,nzbget,sabnzbd,apache --name "$0" -- "$@")"
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
            apps+=("htpc")
			break
			;;
		-p|--plex)
			_plex_install
            apps+=("plex")
			break
			;;
		-s|--sonarr)
			_sonarr_install
			_sonarr_postconfig
            apps+=("sonarr")
			break
			;;
		-S|--sickrage)
			_sick_install
			_sick_postconfig
            apps+=("sickrage")
			break
			;;
		-c|--couchpotato)
            _couchpotato_install
            _couchpotato_postconfig
            apps+=("couchpotato")
			break
			;;
		-n|--nzbget)
        	_nzbget_install
            _nzbget_postconfig
            apps+=("nzbget")			
            break
			;;
		-N|--sabnzbd)
			_sab_install
			#_sab_postconfig
            apps+=("sabnzbd")
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

#sudo reboot

### Script End ###
