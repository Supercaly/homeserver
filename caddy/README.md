# Caddy Reverse Proxy

This service is responsible for implementing the main [Reverse Proxy](https://en.wikipedia.org/wiki/Reverse_proxy) of the home server.

## How it works

The reverse proxy web server sits in front of the other back-end containers and forwards between them and the client all the requests making them appear as if they originated from the proxy server.
This guarantee an higher level of security and scalability.

## TLS/SSL

By default, Caddy serves all sites over HTTPS.
Caddy keeps all managed certificates renewed and redirects HTTP (default port 80) to HTTPS (default port 443) automatically.

## Docker Volumes

This image creates the following docker volumes:

- `caddy_data` used to store caddy certificates
- `caddy_config` used to store caddy configurations

## Docker Networks

This image uses some docker networks:

- `caddy` (external)

## .env

To properly work, this image has some secret environment variables stored inside a `.env` file:

- `EMAIL` email to use to configure TLS certificates
- `DOMAIN_NAME` name of the domain to use
