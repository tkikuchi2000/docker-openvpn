#!/bin/bash
# Revoke client's certificate and generate the certificate revocation list (CRL).
# The OpenVPN server will read this change every time a client connects (no need 
# to restart server) and deny clients access using revoked certificates.
# You can optionally pass 'remove' as second parameter to 'ovpn_revokeclient' to 
# remove the corresponding crt, key and req files.
set -Ceu

CLIENTNAME=${1:-'example-user'}
REMOVE=${2:-''}

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

docker-compose run --rm openvpn ovpn_revokeclient ${CLIENTNAME} ${REMOVE}

### For Docker ############################
#docker run --rm \
#	-v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
#	kylemanna/openvpn \
#	ovpn_revokeclient ${CLIENTNAME} ${REMOVE:-'remove'}

# vi: set et sts=2 sw=2 si ft=sh:
