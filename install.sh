#!/usr/bin/env bash
# Installs the gateway files on this machine. Safe to run more than once.
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root: sudo ./install.sh" >&2
    exit 1
fi

install -d -m 0755 /etc/gateway

# Rule: every task that adds a config file adds its install line below.

# Task 7: static LAN address on the home side
install -m 0644 config/network/gateway-lan /etc/network/interfaces.d/gateway-lan

# Task 9: DHCP on the LAN side, with a lease logger
install -m 0644 config/dnsmasq/dhcp.conf /etc/dnsmasq.d/dhcp.conf
install -m 0755 scripts/dhcp-lease-logger.sh /usr/local/bin/dhcp-lease-logger.sh

# Task 8: forward packets between LAN and WAN, and masquerade on the WAN side
install -m 0644 config/sysctl/90-gateway.conf /etc/sysctl.d/90-gateway.conf
install -m 0644 config/nftables/nftables.conf /etc/nftables.conf
systemctl enable nftables

# Task 10: DNS query log (0640, dnsmasq:adm) and its daily rotation
install -m 0644 config/dnsmasq/dns.conf /etc/dnsmasq.d/dns.conf
install -m 0644 config/logrotate/dnsmasq /etc/logrotate.d/dnsmasq
touch /var/log/dnsmasq.log
chown dnsmasq:adm /var/log/dnsmasq.log
chmod 0640 /var/log/dnsmasq.log
