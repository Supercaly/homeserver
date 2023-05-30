#!/bin/bash

set -e

. /src/includes.sh

PROG_NAME=$0

# restore old backup
if [[ "$1" == "restore" ]]; then
    . /src/restore.sh
    exit 0
fi

# setup crontab
logi "running crond..."
echo "${CRON_TIME} /bin/bash /src/backup.sh" >> "/etc/crontabs/root"
exec crond -f -l 2
