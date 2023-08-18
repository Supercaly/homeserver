# HomeServer

This repository contains a series of configurations for my personal Raspberry PI based home server using Docker.

Every important service is placed inside his own container and every container has his folder. 
The project is structured this way:

- `bitwarden` -> Bitwarden password manager
- `caddy` -> Reverse proxy and HTTPS server
- `crowdsec` -> CrowdSec Intrusion prevention
- `ddns` -> Dynamic DNS manager
- `notify` -> Server used to send notifications from other containers
- `portainer` -> Portainer container manager
- `restic` -> Automatic incremental backup
- `vpn` -> Wireguard VPN
