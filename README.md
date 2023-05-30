# HomeServer

This repository contains all the files to manage the Docker installation of my personal Raspberry PI based home server.

Every important service is placed inside his own container and every container has his folder. The project is structured this way:

- ddns -> Manage the Dynamic DNS
- vpn -> IPSec VPN
- bitwarden -> Bitwarden password manager
  * caddy -> Reverse proxy
  * vaultwarden -> Main Vaultwarden installation
  * vwbackup -> Backup the Bitwarden critical data
