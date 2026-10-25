#!/usr/bin/env bash
# Installs the gateway files on this machine. Safe to run more than once.
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root: sudo ./install.sh" >&2
    exit 1
fi

install -d -m 0755 /etc/gateway

# Rule: every task that adds a config file adds its install line below.