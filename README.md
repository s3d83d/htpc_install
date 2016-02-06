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

To install, download this package.
> cd ~ && git clone https://github.com/s3d83d/htpc_install.git

> cd htpc_install

Choose how you would like to install your applications.
To run, you can try the following scenarios:

| Command | Result |
| ------- | ------ |
| sudo ./install.sh -A | Will install all applications |
| sudo ./install.sh -p | Plex will be installed |
| sudo ./install.sh -s | Sonarr will be installed |
| sudo ./install.sh -c | CouchPotato will be installed |
| sudo ./install.sh -n | NZBGet will be installed |
| sudo ./install.sh -a | Apache will be installed |

If you chose to install all applications, apache will proxy your connections making the connnection urls the following:

| Application | URL |
| ----------- | --- |
| HTPC Manager | http://serverIP/htpc |
| Plex | http://serverIP/web |
| Sonarr | http://serverIP/nzbdrone |
| CouchPotato | http://serverIP/movies |
| NZBget | http://serverIP//nzbget |

NZBGet ships with a default username and password. You can change it after logging in.
| Username | Password |
| -------- | -------- |
| nzbget | tegbzn6789 |

