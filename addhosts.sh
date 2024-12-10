#!/bin/bash


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <IP> <domain>"
    exit 1
fi

IP="$1"
DOMAIN="$2"

if ! [[ "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP address format"
    exit 2
fi

if ! [[ "$DOMAIN" =~ ^[a-zA-Z0-9.-]+$ ]]; then
    echo "Invalid domain name format"
    exit 3
fi

# Check if the script is run as root (required to modify /etc/hosts)
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root"
    exit 4
fi


echo "$IP    $DOMAIN" >> /etc/hosts
echo "Successfully added $DOMAIN to /etc/hosts with IP $IP"
