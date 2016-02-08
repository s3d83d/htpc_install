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
| :------ | :----- |
| sudo ./install.sh -A | Will install all applications |
| sudo ./install.sh -p | Plex will be installed |
| sudo ./install.sh -s | Sonarr will be installed |
| sudo ./install.sh -S | SickRage will be installed |
| sudo ./install.sh -c | CouchPotato will be installed |
| sudo ./install.sh -n | NZBGet will be installed |
| sudo ./install.sh -a | Apache will be installed |

If you chose to install all applications, apache will proxy your connections making the connnection urls the following:

| Application | URL |
| :---------- | :-- |
| *HTPC Manager | http://ip.address/htpc |
| Plex | http://ip.address/web |
| Sonarr | http://ip.address/nzbdrone |
| CouchPotato | http://ip.address/movies |
| NZBget | http://ip.address//nzbget |

\* I cannot get the webdir configuration for HTPC Manager to work. For you you will have to manually configure in the GUI once the service starts. In the settings menu, under general: set Webdir to /htpc for the proxy to work.

If you install applications singularly and/or you do not install apache, you can make connection to these urls:

| Application | URL |
| :---------- | :-- |
| HTPC Manager | http://ip.address:8085/htpc |
| Plex | http://ip.address:32400/web |
| Sonarr | http://ip.address:8989/nzbdrone |
| SickRage | http://ip.address:8081/sickrage |
| CouchPotato | http://ip.address:5050/movies |
| NZBget | http://ip.address:6789//nzbget |

NZBGet ships with a default username and password. You can change it after logging in.

| Username | Password |
| :------- | :------- |
| nzbget | tegbzn6789 |

