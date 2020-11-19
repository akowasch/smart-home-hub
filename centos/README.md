# CentOS

## Installation

## Configuration

``` shell
hostnamectl set-hostname server

dnf upgrade

dnf -y install epel-release
dnf -y install bind-utils
dnf -y install net-tools
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
