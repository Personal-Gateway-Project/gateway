#!/bin/bash
ACTION=$1
MAC=$2
IP=$3

echo "$(date '+%Y-%m-%d %H:%M:%S') - Action: $ACTION, MAC: $MAC, IP: $IP" >> /var/log/dnsmasq-dhcp-leases.log
