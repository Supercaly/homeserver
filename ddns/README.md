# DDNS-Updater

This stack updates automatically the Dynamic DNS (DDNS) using [ddns-updater](https://github.com/qdm12/ddns-updater).

## How it works

The software checks every **5 minutes** if the DNS record for the configured domain names resolves to the current IP address and update the record accordingly.

## Ports

This stack exposes tis ports to the outside:

- `8000/TCP` used for WebUI
