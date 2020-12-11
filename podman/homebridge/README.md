# Homebridge

- Configure environment

  ``` shell
  vi podman/homebridge/.env
  ```

  ``` shell
  export HOMEBRIDGE_PORT='<YOUR_HOMEBRIDGE_PORT>'
  ```

  ``` shell
  source podman/homebridge/.env
  ```

- Create homebridge volumes for data

  ``` shell
  podman volume create homebridge_homebridge
  ```

- Create the container

  ``` shell
  podman run \
    --detach \
    --volume homebridge_homebridge:/homebridge \
    --net host \
    --tz local \
    --pull always \
    --replace \
    --env "HOMEBRIDGE_CONFIG_UI=1" \
    --env "HOMEBRIDGE_CONFIG_UI_PORT=${HOMEBRIDGE_PORT}" \
    --env "PACKAGES=homebridge-hue"
    --name homebridge \
    --hostname homebridge \
    oznu/homebridge:latest
  ```

- Generate systemd service

  ``` shell
  podman generate systemd \
    --name homebridge \
    --new \
    --files \
    --restart-policy=always
  mv -f container-homebridge.service /etc/systemd/system/
  restorecon /etc/systemd/system/container-homebridge.service
  systemctl daemon-reload
  systemctl enable container-homebridge
  systemctl restart container-homebridge
  ```

- Configure firewall

  ``` shell
  # homebridge
  firewall-cmd --permanent --zone=public --add-port=53687/tcp
  firewall-cmd --permanent --zone=public --add-port=53687/udp
  firewall-cmd --reload
  ```

## Useful plugins

- homebridge-xiaomi-roborock-vacuum
- homebridge-ring
