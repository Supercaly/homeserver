#!/bin/bash

function logi() {
    echo "${PROG_NAME}: $1"
}

function loge() {
    echo "\033[31m${PROG_NAME}: $1\033[0m"
}
