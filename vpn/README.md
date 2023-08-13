# VPN

This service is responsible of providing a VPN server using [Wireguard](https://www.wireguard.com/).

## .env

This service has some important environment variables configured inside the `docker-compose.yml` file, but some secret are sotred inside a `.env` file:

- `PUID`/ `PGID` UID and GID for the docker user
- `SERVERURL` domain name used to connect to the VPN
- `SERVERPORT` port number used to connect to the VPN
- `PEERS` list of peer names

# Docker volumes

This service uses the following docker volumes:

- `config` used to store WG configurations

# PORT

This service exposes the followint ports:

- `51820/UDP` used for the VPN connection
