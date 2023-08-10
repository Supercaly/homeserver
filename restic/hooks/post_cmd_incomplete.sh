#! /bin/bash

echo "running post incomplete command hooks..."

curl -X POST \
    -H "Content-Type: application/json" \
    -d "{\"title\": \"Backup incomplete\", \"body\": \"[$(date '+%Y-%m-%d %H:%M:%S')]: Restic backup incomplete.\"}" \
    ${NOTIFICATION_ADDRESS}
