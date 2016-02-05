# htpc_install

This script will harshly install the following packages:

    * HTPC Manager
    * Plex
    * Sonarr/NZBDrone
    * CouchPotato
    * NZBGet
    * Apache

I plan to add logic later to do some fact checking and error handling within the installs.
For now I am just following guides from http://www.htpcguides.com

To run, you can try the following scenarios:

*** To install everything ***
> sudo ./install.sh -A

*** To install just Couchpotato ***
> sudo ./install.sh -c
> or
> sudo ./install.sh --couchpotato


