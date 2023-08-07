# HomeServer

This repository contains all the files to manage the Docker installation of my personal Raspberry PI based home server.

Every important service is placed inside his own container and every container has his folder. The project is structured this way:

- `ddns` -> Manage the Dynamic DNS
- `caddy` -> Reverse proxy
- `bitwarden` -> Bitwarden password manager
- `portainer` -> Portainer container manager
- `vpn` -> IPSec VPN
