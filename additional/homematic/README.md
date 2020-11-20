# HomeMatic CCU3

- Configure domain property

  ``` shell
  export DOMAIN='<YOUR DOMAIN>'
  ```

- Deactivate status leds

  ``` shell
  chmod +x rc.local
  scp rc.local "root@homematic.${DOMAIN}:/usr/local/etc/"
  ```
