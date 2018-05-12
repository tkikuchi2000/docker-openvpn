#!/bin/bash
# If you have more than a few clients, you will want to generate and update your 
# client configuration in batch. For this task the script ovpn_getclient_all was
# written, which writes out the configuration for each client to a separate 
# directory called clients/$cn.
set -Ceu

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

docker-compose run --rm openvpn \
  --volume /tmp/openvpn_clients:/etc/openvpn/clients \
  ovpn_getclient_all

### For Docker ############################
#docker run --rm -it \
#  -v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
#  --volume /tmp/openvpn_clients:/etc/openvpn/clients \
#  kylemanna/openvpn \
#  ovpn_getclient_all

# vi: set et sts=2 sw=2 si ft=sh:
