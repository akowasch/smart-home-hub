# NGINX

- Get official NGINX dnf/yum repo

  ``` shell
  cp nginx.repo /etc/yum.repos.d/
  ```

- Install NGINX

  ``` shell
  dnf install nginx
  ```

- Enable and start NGINX service

  ```shell
  systemctl enable nginx
  systemctl start nginx
  ```

- Configure firewall to allow https

  ``` shell
  firewall-cmd --permanent --zone=public --add-service=https
  firewall-cmd --reload
  ```

- Configure domain property

``` shell
export DOMAIN='<YOUR_DOMAIN>'
```

- Copy ssl certificates (see [ACME](../acme) section)

  ``` shell
  acme.sh -i -d "${DOMAIN}" \
    --key-file /etc/nginx/key.pem \
    --fullchain-file /etc/nginx/cert.pem \
    --reloadcmd 'service nginx force-reload'
  ```

- Generate Diffie-Hellman parameters

  ``` shell
  openssl dhparam -out /etc/nginx/dhparam.pem 2048
  ```

- Allow NGINX to make network connections

  ``` shell
  setsebool -P httpd_can_network_connect 1
  ```

- Delete NGINX default config

  ``` shell
  rm -rf /etc/nginx/conf.d/default.conf
  ```

- Copy NGINX configs (see <https://nginx.org/en/docs/>)

  ``` shell
  cp config/*.conf /etc/nginx/conf.d/
  ```

- Restart NGINX service

  ```shell
  systemctl restart nginx
  ```
