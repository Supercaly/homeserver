#!/bin/bash

set -e

. /src/includes.sh

# restore old backup
if [[ "$1" == "restore" ]]; then
    . /src/restore.sh
    exit 0
fi

# setup crontab
echo "running crond..."
echo "${CRON_TIME} /bin/bash /src/backup.sh" >> "/etc/crontabs/root"
exec crond -f -l 2
