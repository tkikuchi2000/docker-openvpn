#!/bin/bash
# See an overview of the configured clients, including revocation status
set -Ceu

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

docker-compose run --rm openvpn ovpn_listclients

#docker run --rm \
#	-v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
#	kylemanna/openvpn \
#	ovpn_listclients

# vi: set et sts=2 sw=2 si ft=sh:
