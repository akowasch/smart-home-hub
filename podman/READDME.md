# Podman

- Configure registries

``` shell
vi /etc/containers/registries.conf
```

``` toml
unqualified-search-registries = ['docker.io', 'quay.io', 'registry.centos.org', 'registry.fedoraproject.org', 'registry.access.redhat.com']
```
