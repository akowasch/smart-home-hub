# Node-RED

- Create node-red volumes for data and certs

  ``` shell
  podman volume create node_red_user_data
  podman volume create node_red_user_certs
  ```

- Build the container

  ``` shell
  podman build -t node-red .
  ```

- Run the image

  ``` shell
  podman run \
    -d \
    -p 1880:1880 \
    -p 2048:2048 \
    -p 2049:2049 \
    -p 3456:3456 \
    -v node_red_data:/data \
    -v node_red_certs:/certs \
    --net host \
    --tz=local \
    --name node-red \
    -h node-red \
    nodered/node-red:latest-12
  ```

- Generate systemd service

  ``` shell
  podman generate systemd --name node-red --new --restart-policy always
  mv container-node-red.service /etc/systemd/system/
  restorecon /etc/systemd/system/container-node-red.service
  systemctl daemon-reload
  systemctl enable container-node-red
  systemctl start container-node-red
  ```

- Configure firewall

  ``` shell
  # node-red - ui
  firewall-cmd --permanent --zone=public --add-port=1880/tcp
  # node-red - plugin - ccu - BINRPC
  firewall-cmd --permanent --zone=public --add-port=2048/tcp
  # node-red - plugin - ccu - XMLRPC
  firewall-cmd --permanent --zone=public --add-port=2049/tcp
  # node-red - plugin - alexa
  firewall-cmd --permanent --zone=public --add-port=3456/tcp
  firewall-cmd --reload
  ```

- Copy Let's Encrypt certificates (see [Let's Encrypt](../../centos/lets-encrypt) section)

  ``` shell
  podman cp .acme.sh/kowasch.cloud/kowasch.cloud.key node-red:/certs/
  podman cp .acme.sh/kowasch.cloud/fullchain.cer node-red:/certs/
  ```

- Edit settings.js file

  ``` shell
  podman exec -it node-red /bin/bash
  vi settings.js
  ```

  ``` js
  https: function() {
      return {
          key: require("fs").readFileSync('/certs/kowasch.cloud.key'),
          cert: require("fs").readFileSync('/certs/fullchain.cer')
      }
  },

  httpsRefreshInterval : 24,
  ```

## ToDo

- Authentication
- Hardening

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
