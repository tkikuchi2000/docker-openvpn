#!/bin/bash
# Start OpenVPN server process
set -Ceu

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

## For docker-compose ############################
docker-compose up -d openvpn
docker-compose logs -f

## For Docker ####################################
#docker run -d \
#  -p ${BIND_OVPN_PORT:-1194}:1194/udp \
#  -v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
#  --cap-add=NET_ADMIN \
#  kylemanna/openvpn

# vi: set et sts=2 sw=2 si ft=sh:
