# ACME

<https://github.com/acmesh-official/acme.sh>

- Install acme.sh

``` shell
curl https://get.acme.sh | sh
```

- Enable auto-upgrade

``` shell
acme.sh --upgrade --auto-upgrade
```

- Configure domain and dns provider properties

``` shell
export CF_Token='<YOUR_CF_TOKEN>'
export CF_Account_ID='<YOUR_CF_ACCOUNT_ID>'
export CF_Zone_ID='<YOUR_CF_ZONE_ID>'
export DOMAIN='<YOUR_DOMAIN>'
```

- Generate certificates (renewed automatically)

``` shell
acme.sh --issue --dns dns_cf -d "${DOMAIN}" -d "*.${DOMAIN}"
```
