# Bitwarden self-host

This stack manages a self-hosted instance of [Bitwarden](https://bitwarden.com/) using [vaultwarden](https://github.com/dani-garcia/vaultwarden), the unofficial server implementation.

## .env

This stack uses some secret environment variables stored inside a `.env` file:
 
- `DOMAIN` full domain name for vaultwarden end-point
- `ADMIN_TOKEN` token used for accessing the admin panel

## Docker Volumes

This stack uses the following docker volumes:

- `vaultwarden_data` (external) store vaultwarden data

## Docker Networks

This stack uses this docker networks:

- `caddy` (external)
