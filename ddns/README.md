# DDNS-Updater

This service is responsible for automatically updating Dynamic DNS (DDNS).
To do this, it use the properly configured [qmcgaw/ddns-updater](https://github.com/qdm12/ddns-updater) Docker image.

## How it works

The image will check every **5 minutes** if the DNS record resolves to the current IP address and update the record accordingly.

## Important files

- `docker-compose.yml`
- `.env` ([list of available envs](https://github.com/qdm12/ddns-updater#configuration)).
- `data/config.json` containg Dynu domain configuration ([how to config](https://github.com/qdm12/ddns-updater#environment-variables)).

## Web UI

The image offers a Web UI to view the current status; the site is accessible at port **8000**.
