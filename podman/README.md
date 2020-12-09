# Podman

- Use latest container-tools

  ``` shell
  dnf -y module disable container-tools
  dnf -y install 'dnf-command(copr)'
  dnf -y copr enable rhcontainerbot/container-selinux
  curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/CentOS_8_Stream/devel:kubic:libcontainers:stable.repo
  ```

- Install podman (with overlayfs)

  ``` shell
  dnf -y install podman
  dnf -y install fuse-overlayfs
  ```

- Configure search registries

  ``` shell
  vi /etc/containers/registries.conf
  ```

  ``` text
  unqualified-search-registries = ['docker.io', 'quay.io', 'registry.centos.org', 'registry.fedoraproject.org', 'registry.access.redhat.com']
  ```

- Install buildah

  ``` shell
  dnf -y install buildah
  ```

- Install skopeo

  ``` shell
  dnf -y install skopeo
  ```

## Optional use of separated container ips

- Configure environment

  ``` shell
  vi podman/.env
  ```

  ``` shell
  export HOST_IF='<YOUR_INTERFACE>'
  ```

  ``` shell
  source podman/.env
  ```

- Create cni configuration

  ``` shell
  cp podman/host-local-bridge.conflist /etc/cni/net.d/
  ```

- Create network bridge

  ``` shell
  nmcli con add type bridge con-name br0 ifname br0
  nmcli con mod br0 ipv4.method auto
  nmcli con del "${HOST_IF}"
  nmcli con add type bridge-slave con-name "${HOST_IF}" ifname "${HOST_IF}" master br0
  nmcli con up br0
  ```
