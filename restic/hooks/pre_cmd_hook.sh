#! /bin/bash

echo "running pre commands hooks..."

VW_DATA_PATH="/mnt/vw_data"
VW_BKP_PATH="/data/vw"

if [[ ! -e "${VW_BKP_PATH}" ]]; then
    echo "'${VW_BKP_PATH}' directory not exist, creating it..."
    mkdir -p "${VW_BKP_PATH}"
fi

# copy vw data to backup folder
echo "copying bitwarden data to '${VW_BKP_PATH}'..."
if [[ -f "${VW_DATA_PATH}/db.sqlite3" ]]; then
    sqlite3 "${VW_DATA_PATH}/db.sqlite3" ".backup '${VW_BKP_PATH}/db.sqlite3'"
else
    echo "sqlite database not found, skipping"
fi
if [[ -f "${VW_DATA_PATH}/config.json" ]]; then
    cp -f "${VW_DATA_PATH}/config.json" "${VW_BKP_PATH}/config.json"
else
    echo "config.json not found, skipping"
fi
if [[ -f "${VW_DATA_PATH}/rsa_key.pem" && -f "${VW_DATA_PATH}/rsa_key.pub.pem" ]]; then
    cp -f "${VW_DATA_PATH}/rsa_key.pem" "${VW_BKP_PATH}/rsa_key.pem"
    cp -f "${VW_DATA_PATH}/rsa_key.pub.pem" "${VW_BKP_PATH}/rsa_key.pub.pem"
else
    echo "rsa_keys not found, skipping"
fi
if [[ -d "${VW_DATA_PATH}/attachments" ]]; then
    cp -rf "${VW_DATA_PATH}/attachments" "${VW_BKP_PATH}/attachments"
else
    echo "attachments directory not found, skipping"
fi
if [[ -d "${VW_DATA_PATH}/sends" ]]; then
    cp -rf "${VW_DATA_PATH}/sends" "${VW_BKP_PATH}/sends"
else
    echo "sends directory not found, skipping"
fi
echo "done"
