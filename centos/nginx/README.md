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
  firewall-cmd --permanent --add-service=https
  firewall-cmd --reload
  ```

- Copy ssl certificates (see [ACME](../acme) section)

  ``` shell
  acme.sh -i \
  -d '<YOUR_DOMAIN>' \
  --key-file /etc/nginx/key.pem  \
  --fullchain-file /etc/nginx/cert.pem \
  --reloadcmd 'service nginx force-reload'
  ```

- Configure NGINX (see <https://nginx.org/en/docs/>)

  ``` shell
  rm -rf /etc/nginx/conf.d/default.conf
  openssl dhparam -out /etc/nginx/dhparam.pem 2048
  setsebool -P httpd_can_network_connect 1
  cp config/*.conf /etc/nginx/conf.d/
  systemctl restart nginx
  ```
