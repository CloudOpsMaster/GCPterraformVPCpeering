#!/bin/bash

if ! [ $(id -u) = 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

update_os() {
    apt update -y
    apt full-upgrade -y
}