# ACME

<https://github.com/acmesh-official/acme.sh>

``` shell
curl https://get.acme.sh | sh
acme.sh --upgrade --auto-upgrade

export CF_Token='<YOUR_CF_TOKEN>'
export CF_Account_ID='<YOUR_CF_ACCOUNT_ID>'
export CF_Zone_ID='<YOUR_CF_ZONE_ID>'

acme.sh --issue --dns dns_cf -d '<YOUR_DOMAIN>' -d '*.<YOUR_DOMAIN>'
```
