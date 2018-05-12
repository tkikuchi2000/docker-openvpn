#!/bin/bash
# Retrieve the client configuration with embedded certificates
set -Ceu

CLIENTNAME=${1:-'example-user'}

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

# Get client configuration
## For docker-compose ####################
docker-compose run --rm openvpn \
  --log-driver=none \
  ovpn_getclient ${CLIENTNAME} > ${CLIENTNAME}.ovpn

## For Docker ############################
#docker run --rm \
#	-v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
#	kylemanna/openvpn \
#	ovpn_getclient ${CLIENTNAME} > ${CLIENTNAME}.ovpn

# vi: set et sts=2 sw=2 si ft=sh:
