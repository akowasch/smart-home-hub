# HomeMatic CCU3

- Deactivate status leds

  ``` shell
  scp rc.local /usr/local/etc/
  chmod +x /usr/local/etc/rc.local
  ```

- Configure domain and ip properties

  ``` shell
  export DOMAIN='<YOUR DOMAIN>'
  export IP='<YOUR_IP>'
  ```

- Create leaf certificate (see [Root-CA](../root-ca))

  ``` shell
  step certificate create "homematic.${DOMAIN}" "homematic.${DOMAIN}.crt" "homematic.${DOMAIN}.key" \
    --profile leaf \
    --ca ./root-ca.crt \
    --ca-key ./root-ca.key \
    --san "homematic.${DOMAIN}" \
    --san "${IP}" \
    --not-after 8760h \
    --kty RSA \
    --size 2048 \
    --no-password \
    --insecure
  ```

- Combine key and certificate

  ``` shell
  cat "homematic.${DOMAIN}.key" "homematic.${DOMAIN}.crt" > "homematic.${DOMAIN}.pem"
  ```

- Upload file to HomeMatic CCU3
