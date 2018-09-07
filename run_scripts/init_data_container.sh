#!/bin/bash
# Initialize the $OVPN_DATA container that will hold the configuration files and 
# certificates. The container will prompt for a passphrase to protect the private
# key used by the newly generated certificate authority.
set -Ceu

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

docker-compose run --rm openvpn ovpn_genconfig -u udp://${VPN_SERVER_NAME:-127.0.0.1}
docker-compose run --rm openvpn ovpn_initpki

### For Docker ###################################
### Create data container ${OVPN_DATA}
#docker volume create --name ${OVPN_DATA:=ovpn-data-example}
#
### Generate config 
#docker run -v ${OVPN_DATA}:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://${VPN_SERVER_NAME:-127.0.0.1}
##
### Initialize PKI
#docker run -v ${OVPN_DATA}:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

# vi: set et sts=2 sw=2 si ft=sh:
