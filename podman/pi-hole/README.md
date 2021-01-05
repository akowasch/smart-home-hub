# Pi-hole

- Configure environment

  ``` shell
  vi podman/pi-hole/.env
  ```

  ``` shell
  export HOST_IF='<YOUR_INTERFACE>'
  export HOST_IP='<YOUR_IP>'
  export PI_HOLE_PORT='<YOUR_PI_HOLE_PORT>'
  export DOMAIN='<YOUR_DOMAIN>'
  ```

  ``` shell
  source podman/pi-hole/.env
  ```

- Create node-red volumes for data

  ``` shell
  podman volume create pi_hole_etc_pihole
  podman volume create pi_hole_etc_dnsmasq
  ```

- Create the image

  ``` shell
  podman run \
    --detach \
    --volume pi_hole_etc_pihole:/etc/pihole \
    --volume pi_hole_etc_dnsmasq:/etc/dnsmasq.d \
    --net host \
    --tz local \
    --pull always \
    --replace \
    --dns 127.0.0.1 \
    --dns 8.8.8.8 \
    --env "DNS1=8.8.8.8" \
    --env "DNS2=8.8.4.4" \
    --env "ServerIP=${HOST_IP}" \
    --env "VIRTUAL_HOST=pi-hole.${DOMAIN}" \
    --env "WEB_PORT=${PI_HOLE_PORT}" \
    --env "INTERFACE=${HOST_IF}" \
    --env "DNSMASQ_LISTENING=all" \
    --env "WEBUIBOXEDLAYOUT=traditional" \
    --name pi-hole \
    --hostname pi-hole \
    pihole/pihole:latest
  ```

- Get random generated password

  ``` shell
  podman logs pi-hole | grep random
  ```

- Optional: Set new custom password

  ``` shell
  podman exec -it pi-hole pihole -a -p '<NEW_PASSWORD>'
  ```

- Generate systemd service

  ``` shell
  podman generate systemd \
    --name pi-hole \
    --new \
    --files \
    --restart-policy=always
  mv -f container-pi-hole.service /etc/systemd/system/
  restorecon /etc/systemd/system/container-pi-hole.service
  systemctl daemon-reload
  systemctl enable container-pi-hole
  systemctl restart container-pi-hole
  ```

- Configure firewall

  ``` shell
  # pi-hole - dns - tcp
  firewall-cmd --permanent --zone=public --add-port=53/tcp
  # pi-hole - dns - udp
  firewall-cmd --permanent --zone=public --add-port=53/udp
  firewall-cmd --reload
  ```

- Optional: Update Pi-hole gravity

  ``` shell
  podman exec -it pi-hole pihole -g
  ```

- Optional: Add custom addlists

  ``` shell
  podman cp podman/pi-hole/adlists.list pi-hole:/etc/pihole/adlists.list
  ```
