# DDNS-Updater

This stack updates automatically the Dynamic DNS (DDNS) using [ddns-updater](https://github.com/qdm12/ddns-updater).

## How it works

The software checks every **5 minutes** if the DNS record for the configured domain names resolves to the current IP address and update the record accordingly.

## Config

The process to configure the hosts that needs to be updated is a little bit different from the other containers.
The hosts are loaded from a `config.json` filed stored inside the `data` directory.
To easily create all the files run the container normally, this will create the `data` directory with correct permissions; then edit the `config.json` file inside with every hosts.

Note: The `data` directory is not a docker volume because it causes some problems if it's not a bind mounted local directory. Moreover there is a permission related problem that can arise; read more [here](https://github.com/qdm12/ddns-updater#setup).

## Docker Networks

This stack uses this docker networks:

- `ddns_default` (internal)

## Ports

This stack exposes tis ports to the outside:

- `8000/TCP` used for WebUI
