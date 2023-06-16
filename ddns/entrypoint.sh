#!/bin/bash

set -xe

echo "${CRON_TIME} python3 -u /src/update.py" >> "/etc/crontabs/root"
exec crond -f -l 2
