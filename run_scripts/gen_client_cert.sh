#!/bin/bash
# Generate a client certificate without a passphrase
set -Ceu

CLIENTNAME=${1:-'example-user'}
NOPASS=${2:-''}

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

docker-compose run --rm openvpn easyrsa build-client-full ${CLIENTNAME} ${NOPASS}

## For Docker ############################
#docker run --rm -it \
#  -v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
#  kylemanna/openvpn \
#  easyrsa build-client-full ${CLIENTNAME} nopass

# vi: set et sts=2 sw=2 si ft=sh:
