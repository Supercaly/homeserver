# Caddy Reverse Proxy

This stack serves the main [Reverse Proxy](https://en.wikipedia.org/wiki/Reverse_proxy) of the HomeServer using [Caddy](https://caddyserver.com/) web server.

## How it works

The reverse proxy sits in front of the other containers and forwards the requests between them and the clients making them appear as if they originated from the proxy server.
This guarantee an higher level of security and scalability.

## TLS/SSL

By default, Caddy serves all sites over HTTPS.
Caddy keeps all managed certificates renewed and redirects HTTP (default port 80) to HTTPS (default port 443) automatically.

## .env

This stack uses some secret environment variables stored inside a `.env` file:

- `EMAIL` email to use to configure TLS certificates
- `DOMAIN_NAME` name of the domain to use

## Docker Volumes

This stack uses this docker volumes:

- `data` store caddy certificates
- `config` store caddy configurations

## Docker Networks

This stack uses this docker networks:

- `caddy_default` (internal)

## Ports

This stack exposes this ports to the outside:

- `80/TCP` used for HTTP
- `443/TCP` used for HTTPS
