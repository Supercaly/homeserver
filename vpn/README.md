# VPN

This stack provides a VPN server using [Wireguard](https://www.wireguard.com/).

## .env

This stack uses some secret environment variables sotred inside a `.env` file:

- `PUID`/ `PGID` UID and GID for the docker user
- `SERVERURL` domain name used to connect to the VPN
- `SERVERPORT` port number used to connect to the VPN
- `PEERS` list of peer names

# Docker Volumes

This stack uses this docker volumes:

- `config` store WG configurations

## Docker Networks

This stack uses this docker networks:

- `vpn_default` (internal)

# Ports

This stack exposes this ports to the outside:

- `51820/UDP` used for WG connection
