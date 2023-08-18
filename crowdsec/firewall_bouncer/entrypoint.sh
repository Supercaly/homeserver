#! /bin/bash

# Subtitute values from environment variables to bouncer config file
envsubst < crowdsec-firewall-bouncer.yaml > bouncer_config.yaml

exec $@
