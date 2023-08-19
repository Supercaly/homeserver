# Portainer

This stack provides the [Portainer](https://www.portainer.io/) WebUI tool.

## Docker Volumes

This stack uses this docker volumes:

- `data` store portainer data

## Docker Networks

This stack uses this docker networks:

- `portainer_default` (internal)

# Ports

This stack exposes this ports to the outside:

- `9000/TCP` used for the WebUI
