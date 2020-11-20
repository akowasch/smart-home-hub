# Root-CA

Wherever possible Let's Encrypt certificates should be used. However, these cannot be used everywhere. Especially in proprietary systems, certificates can often only be added manually. A root CA is created for this purpose.

- [Preparation](#preparation)
- [Root-CA Certificate](#root-ca-certificate)
- [Leaf Certificates](#leaf-certificates)
  - [UniFi Security Gateway](#unifi-security-gateway)
  - [UniFi Cloud Key](#unifi-cloud-key)
  - [HomeMatic](#homematic)
  - [Fritz!Box](#fritzbox)

## Preparation

- Download step cli (see <https://github.com/smallstep/cli>)

  ``` shell
  # macOS
  brew install step
  ```

  ``` shell
  # Debian Linux
  VERSION=0.15.3
  wget "https://github.com/smallstep/cli/releases/download/v0.15.3/step-cli_${VERSION}_amd64.deb"
  sudo dpkg -i "step-cli_${VERSION}_amd64.deb"
  ```

  ``` shell
  # Arch Linux
  pacman -S step-cli
  ```

  ``` shell
  # Other Linux
  VERSION=0.15.3
  wget -c "https://github.com/smallstep/cli/releases/download/v${VERSION}/step_linux_${VERSION}_amd64.tar.gz" -O - | \
    tar -xzvf - --strip-components 2 -C /usr/local/bin/ "step_${VERSION}/bin/step"
  chmod +x /usr/local/bin/step
  ```

## Root-CA Certificate

- Create root-ca certificate

  ``` shell
  step certificate create root-ca root-ca.crt root-ca.key \
    --profile root-ca \
    --kty RSA \
    --size 4096
  ```

## Leaf Certificates

``` shell
export DOMAIN='<YOUR_DOMAIN>'
```

### UniFi Security Gateway

- Create leaf certificate

  ``` shell
  export IP='<YOUR_IP>'
  step certificate create "fritz-box.${DOMAIN}" "fritz-box.${DOMAIN}.crt" "fritz-box.${DOMAIN}.key" \
    --profile leaf \
    --ca root-ca.crt \
    --ca-key root-ca.key \
    --san "unifi-ck.${DOMAIN}" \
    --san "${IP}" \
    --not-after 8760h \
    --kty RSA \
    --size 2048 \
    --no-password \
    --insecure
  ```

- Combine key and certificate

  ``` shell
  cat "fritz-box.${DOMAIN}.key" "fritz-box.${DOMAIN}.crt" > "fritz-box.${DOMAIN}.pem"
  ```

### UniFi Cloud Key

- Create leaf certificate

  ``` shell
  export IP='<YOUR_IP>'
  step certificate create "unifi-ck.${DOMAIN}" "unifi-ck.${DOMAIN}.crt" "unifi-ck.${DOMAIN}.key" \
    --profile leaf \
    --ca root-ca.crt \
    --ca-key root-ca.key \
    --san "unifi-ck.${DOMAIN}" \
    --san "${IP}" \
    --not-after 8760h \
    --kty RSA \
    --size 2048 \
    --no-password \
    --insecure
  ```

- Combine key and certificate

  ``` shell
  cat "unifi-ck.${DOMAIN}.key" "unifi-ck.${DOMAIN}.crt" > "unifi-ck.${DOMAIN}.pem"
  ```

### HomeMatic

- Create leaf certificate

  ``` shell

  export IP='<YOUR_IP>'
  step certificate create "homematic.${DOMAIN}" "homematic.${DOMAIN}.crt" "homematic.${DOMAIN}.key" \
    --profile leaf \
    --ca root-ca.crt \
    --ca-key root-ca.key \
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

### Fritz!Box

- Create leaf certificate

  ``` shell
  export IP='<YOUR_IP>'
  step certificate create "fritz-box.${DOMAIN}" "fritz-box.${DOMAIN}.crt" "fritz-box.${DOMAIN}.key" \
    --profile leaf \
    --ca root-ca.crt \
    --ca-key root-ca.key \
    --san "fritz-box.${DOMAIN}" \
    --san "${IP}" \
    --not-after 8760h \
    --kty RSA \
    --size 2048 \
    --no-password \
    --insecure
  ```

- Combine key and certificate

  ``` shell
  cat "fritz-box.${DOMAIN}.key" "fritz-box.${DOMAIN}.crt" > "fritz-box.${DOMAIN}.pem"
  ```
