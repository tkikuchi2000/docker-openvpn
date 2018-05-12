# Quick Start 


```bash
$ cat .env
#DEBUG=1
BIND_OVPN_PORT=<UDP_BINDPORT>
VPN_SERVER_NAME=<MY.GATEWAY.IP.ADDRESS>
OVPN_DATA=openvpn-data/conf

$ mkdir -p openvpn-data/conf

$ cat docker-compose.yml
version: '3'
services:
  openvpn:
    container_name: openvpn
    build: 
      context: .
      dockerfile: Dockerfile.arm32v6
    volumes:
      - ./openvpn-data/conf:/etc/openvpn
    ports:
      - "${BIND_OVPN_PORT}:1194/udp"
    cap_add:
      - NET_ADMIN
    restart: always
    logging:
      driver: "none"
    env_file:
      - .env

# vi: set et sts=2 si sw=2:
```

- Initialize container and hold the configuration files and certificates

  ```bash
  $ cd run_scripts
  $ bash init_data_container.sh
  ```

- Start OpenVPN server

  ```bash
  $ cd run_scripts
  $ bash start_ovpn_server.sh
  ```

- Generate a client certificate without a passphrase

  ```bash
  $ cd run_scripts
  $ bash gen_cert_nopass.sh
  ```

- Retrieve the client configuration with embedded certificates

  ```bash
  $ cd run_scripts
  $ bash retrieve_client_conf.sh
  ```
