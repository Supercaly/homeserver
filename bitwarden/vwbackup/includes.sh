#!/bin/bash

function logi() {
    echo "[$(date "+%F-%H%M%S")] I: ${PROG_NAME}: $1"
}

function loge() {
    echo "[$(date "+%F-%H%M%S")] E: ${PROG_NAME}: $1"
}
