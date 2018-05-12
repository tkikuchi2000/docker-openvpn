#!/bin/bash
# Backup configuration and certificates
set -Ceu

# Backup to Archive
backup() {
  : backup to archive.
	docker run --rm \
		-v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
		kylemanna/openvpn \
		tar -cvf - -C /etc openvpn | xz > ${FILE_NAME}
}

# Restore to New Data Volume
restore() {
  : restore to new data volume.
  xzcat ${FILE_NAME} \
  | docker run -i \
      -v ${OVPN_DATA:-'ovpn-data-example'}:/etc/openvpn \
      kylemanna/openvpn \
      tar -xvf - -C /etc

}

# Set script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-${0}}")" && pwd)"

# Parse .env if exists
if [ -e ${SCRIPT_DIR}/../.env ]; then
  : Parse dotenv
  export $(grep -v '^#' ${SCRIPT_DIR}/../.env|xargs)
fi

# Backup file name
FILE_NAME=${2:-'openvpn-backup.tar.xz'}

# Backup or Restore
if [ -z "${1:+IS_EMPTY}" ]; then
  : 'exit' with error code.
	exit 1
else 
	case "${1}" in
		backup)  backup ;;
		restore) restore ;;
		*) exit 1 ;;
	esac
fi

# vi: set et sts=2 sw=2 si ft=sh:
