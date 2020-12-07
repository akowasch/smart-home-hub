# Node-RED

- Create node-red volumes for data

  ``` shell
  podman volume create node_red_user_data
  ```

- Optional: Build your own image

  ``` shell
  podman build -t node-red podman/node-red
  ```

- Create the container

  ``` shell
  podman run \
    --detach \
    --volume node_red_data:/data \
    --net host_local_bridge \
    --ip 192.168.42.130 \
    --tz local \
    --pull always \
    --replace \
    --name node-red \
    --hostname node-red \
    nodered/node-red:latest-12
  ```

- Generate systemd service

  ``` shell
  podman generate systemd --name node-red --new --files
  mv -f container-node-red.service /etc/systemd/system/
  restorecon /etc/systemd/system/container-node-red.service
  systemctl daemon-reload
  systemctl enable container-node-red
  systemctl restart container-node-red
  ```

- Configure firewall

  ``` shell
  # node-red - plugin - ccu - BINRPC
  firewall-cmd --permanent --zone=public --add-port=2048/tcp
  # node-red - plugin - ccu - XMLRPC
  firewall-cmd --permanent --zone=public --add-port=2049/tcp
  # node-red - plugin - alexa
  firewall-cmd --permanent --zone=public --add-port=3456/tcp
  # node-red - plugin - homekit - 5353
  firewall-cmd --permanent --zone=public --add-service=mdns
  firewall-cmd --permanent --zone=public --add-port=51826/tcp
  firewall-cmd --reload
  ```

- Generate password hash

  ``` shell
  podman exec -it node-red /bin/bash
  npx node-red admin hash-pw
  ```

- Configure authentication

  ``` shell
  podman exec -it node-red /bin/bash
  vi settings.js
  ```

  ``` shell
  adminAuth: {
    type: "credentials",
    users: [
      {
        username: "Admin",
        password: "<YOUR_PASSWORD_HASH>",
        permissions: "*"
      },
    ]
  },
  ```

## List of Useful Plugins

- Dashboard plugins
  - node-red-dashboard
  - node-red-contrib-ui-contextmenu
  - node-red-contrib-ui-led
  - node-red-contrib-ui-level
  - node-red-contrib-ui-svg
  - node-red-node-ui-list
  - node-red-node-ui-table

- Homekit plugins
  - redmatic-homekit
  - node-red-contrib-homekit-bridged

- HomeMatik plugins
  - node-red-contrib-ccu

- Alexa plugins
  - node-red-contrib-alexa-remote2

- Google Cast plugins
  - node-red-contrib-cast
  - node-red-contrib-castv2
  - node-red-contrib-google-home-notify

- Hue plugins
  - node-red-contrib-huemagic

- Netatmo plugins
  - node-red-contrib-netatmo-dashboard

- Nuki plugins
  - node-red-contrib-nuki

- Unifi plugins
  - node-red-contrib-unifi

- Pushover plugin
  - node-red-node-pushover

- Other plugins
  - node-red-contrib-combine
  - node-red-contrib-daylight-rgbw
  - node-red-contrib-german-holidays
  - node-red-contrib-moment
  - node-red-contrib-sun-position
  - node-red-node-base64
  - node-red-node-email
  - node-red-node-random
