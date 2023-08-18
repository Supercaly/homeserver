# CrowdSec

This stack serves the [crowdsec](https://github.com/crowdsecurity/crowdsec) application for detecting and managing hostile behaviours and attacks to the network.

The components of Crowdsec present in this stack are:

- LAPI (Local API) the crowdsec local API that manages everything
- Agent the agent that checks log files for behaviours
- Firewall Bouncer that bans the attackers

The stack was setup using [this tutorial](https://www.smarthomebeginner.com/crowdsec-docker-compose-1-fw-bouncer/).
 
## Agent

The LAPI and Agent are merged inside the same [image](https://hub.docker.com/r/crowdsecurity/crowdsec).

### Docker Volumes

This image uses this docker volumes:

- `agent_data` store LAPI and agent data
- `agent_config` store LAPI and agent configs

## Docker Networks

This image uses this docker networks:

- `notification` (external)

### Ports

This image exposes this ports to the outside:

- `8080/TCP` for API

## Firewall Bouncer

The Firewall bouncer image implements the [Crowdsec Firewall Bouncer](https://docs.crowdsec.net/docs/bouncers/firewall/) as suggested by [this comment](https://github.com/crowdsecurity/cs-firewall-bouncer/issues/32#issuecomment-1060890534).

### Setup

Before running this image it's important to get an API key for the bouncer from the LAPI. Without a key the bouncer is not able to talk to the LAPI.

To abtain an API key we need to register a new bouncer to the LAPI running the following command:

```bash
$ docker exec cs_agent cscli bouncers add docker_firewall_bouncer
```

The API key returned must be copyed and pasted in the `API_KEY` field of the `.env` file.

### .env

This image uses some secret environment variables stored inside a `.env` file:

- `API_KEY` key for the bouncer to access the LAPI

### Docker Networks

This image uses this docker networks:

- `host`
