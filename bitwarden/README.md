# Bitwarden self-host

This service is responsibe of managing the self-hosted instance of [Bitwarden](https://bitwarden.com/) through the unofficial implementation called [vaultwarden](https://github.com/dani-garcia/vaultwarden).

## .env

This service has some important environment variable already configured inside the `docker-compose.yml` file, but some secret are stored inside a `.env` file:
 
- `DOMAIN` full domain name for vaultwarden end-point
- `ADMIN_TOKEN` token used for accessing the admin panel

## Docker Volumes

This service creates the following docker volumes:

- `vaultwarden_data` (external) used to store vaultwarden data

## Docker Networks

The vaultwarden image uses this docker networks:

- `caddy` (external)
