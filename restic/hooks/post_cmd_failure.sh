#! /bin/bash

echo "running post failure command hooks..."

curl -X POST \
    -H "Content-Type: application/json" \
    -d "{\"title\": \"Backup failed\", \"body\": \"[$(date '+%Y-%m-%d %H:%M:%S')]: Restic backup failed.\"}" \
    ${NOTIFICATION_ADDRESS}
