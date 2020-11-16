# CentOS

## Installation

## Configuration

``` shell
hostnamectl set-hostname server

dnf upgrade

dnf -y install epel-release
dnf -y install bind-utils
dnf -y install wget
dnf -y install tree
dnf -y install tar
dnf -y install dnf-automatic
```

``` shell
vi /etc/dnf/automatic.conf
```

``` toml
[commands]
upgrade_type = security
apply_updates = yes
```

``` shell
systemctl enable --now dnf-automatic.timer
systemctl list-timers *dnf-*
```

``` shell
wget https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64 -O /usr/bin/yq && chmod +x /usr/bin/yq
```

``` shell
# Updated podman, buildah and skkopeo
dnf -y module disable container-tools
dnf -y install 'dnf-command(copr)'
dnf -y copr enable rhcontainerbot/container-selinux
curl -L -o /etc/yum.repos.d/devel:kubic:libcontainers:stable.repo https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/CentOS_8_Stream/devel:kubic:libcontainers:stable.repo
dnf -y install podman
dnf -y install fuse-overlayfs
dnf -y install buildah
dnf -y install skopeo
```

``` shell
vi /etc/systemd/logind.conf
```

``` text
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

``` shell
systemctl restart systemd-logind.service
```
