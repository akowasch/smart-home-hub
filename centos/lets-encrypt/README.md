# Let's Encrypt

<https://github.com/acmesh-official/acme.sh>

``` shell
curl https://get.acme.sh | sh
acme.sh --upgrade --auto-upgrade
export CF_Token="xxx" && export CF_Account_ID="xxx" && export CF_Zone_ID="xxx"
acme.sh --issue --dns dns_cf -d kowasch.cloud -d '*.kowasch.cloud'
```
