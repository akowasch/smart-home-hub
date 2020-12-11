# ioBroker

- Configure environment

  ``` shell
  vi podman/iobroker/.env
  ```

  ``` shell
  export IOBROKER_ADMIN_PORT='<YOUR_IOBROKER_ADMIN_PORT>'
  export IOBROKER_OBJECTSDB_PORT='<YOUR_IOBROKER_OBJECTSDB_PORT>'
  export IOBROKER_STATESDB_PORT='<YOUR_IOBROKER_STATESDB_PORT>'
  ```

  ``` shell
  source podman/iobroker/.env
  ```

- Create ioBroker volumes for data

  ``` shell
  podman volume create iobroker_opt_iobroker
  ```

- Create the container

  ``` shell
  podman run \
    --detach \
    --volume iobroker_opt_iobroker:/opt/iobroker \
    --net host \
    --tz local \
    --pull always \
    --replace \
    --privileged \
    --env "IOB_ADMINPORT=${IOBROKER_ADMIN_PORT}" \
    --env "OBJECTSDB_PORT=${IOBROKER_OBJECTSDB_PORT}" \
    --env "STATESDB_PORT=${IOBROKER_STATESDB_PORT}" \
    --name iobroker \
    --hostname iobroker \
    buanet/iobroker:latest-v5
  ```

  **ToDo**: remove `--privileged`

- Generate systemd service

  ``` shell
  podman generate systemd \
    --name iobroker \
    --new \
    --files \
    --restart-policy=always
  mv -f container-iobroker.service /etc/systemd/system/
  restorecon /etc/systemd/system/container-iobroker.service
  systemctl daemon-reload
  systemctl enable container-iobroker
  systemctl restart container-iobroker
  ```
