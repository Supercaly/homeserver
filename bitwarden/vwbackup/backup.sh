#!/bin/bash

set -e

. /src/includes.sh

function backup_data_to_tmp() {
    local DATA_DB_SQLITE="${DATA_DIR}/db.sqlite3"
    local DATA_CONFIG="${DATA_DIR}/config.json"
    local DATA_RSA="${DATA_DIR}/rsa_key.pem"
    local DATA_RSA_PUB="${DATA_DIR}/rsa_key.pub.pem"
    local DATA_ATTACHMENTS="${DATA_DIR}/attachments"
    local DATA_SENDS="${DATA_DIR}/sends"
    
    local TMP_DB_SQLITE="${TMP_DIR}/db.sqlite3"
    local TMP_CONFIG="${TMP_DIR}/config.json"
    local TMP_RSA="${TMP_DIR}/rsa_key.pem"
    local TMP_RSA_PUB="${TMP_DIR}/rsa_key.pub.pem"
    local TMP_ATTACHMENTS="${TMP_DIR}/attachments"
    local TMP_SENDS="${TMP_DIR}/sends"

    logi "copy vaultwarden sqlite database"
    if [[ -f "${DATA_DB_SQLITE}" ]]; then
        sqlite3 "${DATA_DB_SQLITE}" ".backup '${TMP_DB_SQLITE}'"
    else
        loge "not found vaultwarden sqlite database, skipping"
    fi

    logi "copy vaultwarden config"
    if [[ -f "${DATA_CONFIG}" ]]; then
        cp -f "${DATA_CONFIG}" "${TMP_CONFIG}"
    else
        loge "not found vaultwarden config, skipping"
    fi

    logi "copy vaultwarden rsakey"
    if [[ -f "${DATA_RSA}" && -f "${DATA_RSA_PUB}" ]]; then
        cp -f "${DATA_RSA}" "${TMP_RSA}"
        cp -f "${DATA_RSA_PUB}" "${TMP_RSA_PUB}"
    else
        loge "not found vaultwarden rsakeys, skipping"
    fi

    logi "copy vaultwarden attachments"
    if [[ -d "${DATA_ATTACHMENTS}" ]]; then
        cp -rf "${DATA_ATTACHMENTS}" "${TMP_ATTACHMENTS}"
    else
        loge "not found vaultwarden attachments directory, skipping"
    fi

    logi "copy vaultwarden sends"
    if [[ -d "${DATA_SENDS}" ]]; then
        cp -rf "${DATA_SENDS}" "${TMP_SENDS}"
    else
        loge "not found vaultwarden sends directory, skipping"
    fi
}

function package_backup_data() {
    # move to tmp dir
    local OLD_PWD=$(pwd)
    cd "${TMP_DIR}"

    logi "package backup to '${BACKUP_FILE_PATH}'"
    tar -czvf - . | openssl enc -e -aes256 -salt -pbkdf2 -pass pass:${BACKUP_ENCRYPTION_KEY} \
        -out "${BACKUP_FILE_PATH}"

    # move back to root
    cd "${OLD_PWD}"

    logi "done"
}

function clean_old_backups() {
    # move to backup dir
    local OLD_PWD=$(pwd)
    cd "${BACKUP_DIR}"

    logi "remove backups older than 30 days:"
    ! find ./*.tar.gz -maxdepth 1 -type f -name "backup_*.tar.gz" -mtime +30 -print -delete

    # move back to root
    cd "${OLD_PWD}"

    logi "done"
}

function upload_backup() {
    logi "upload backup file to storage system"
    # rclone copy "${BACKUP_FILE_PATH}" "${RCLONE_REMOTE}:${RCLONE_BACKUP_FOLDER}"
    rclone sync "${BACKUP_DIR}" "${RCLONE_REMOTE}:${RCLONE_BACKUP_FOLDER}"
    logi "done"
}

#####################
# Start of main body
#####################

PROG_NAME=$0

DATA_DIR="/vw_data"
BACKUP_DIR="/vw_backup"
TMP_DIR="/tmp/backup"

# check data dir
if [[ ! -d "${DATA_DIR}" ]]; then
    loge "cannot find folder '${DATA_DIR}'"
    exit 1
fi
# check backup dir
if [[ ! -d "${BACKUP_DIR}" ]]; then
    loge "cannot find folder '${BACKUP_DIR}'"
    exit 1
fi

BACKUP_FILE_PATH="${BACKUP_DIR}/backup_$(date "+%F-%H%M%S").tar.gz"

# prepare tmp dir
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

clean_old_backups

backup_data_to_tmp
package_backup_data

# clean-up
rm -rf "${TMP_DIR}"

upload_backup
