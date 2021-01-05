# CentOS

## Installation

## Configuration

- Configure hostname

  ``` shell
  hostnamectl set-hostname server
  ```

- Upgrade installed packages

  ``` shell
  dnf upgrade
  ```

- Install required and useful packages

  ``` shell
  dnf -y install epel-release
  dnf -y install bind-utils
  dnf -y install net-tools
  dnf -y install wget
  dnf -y install tree
  dnf -y install tar
  dnf -y install dnf-automatic
  dnf -y install git
  ```

  ``` shell
  VERSION=3.4.1
  wget "https://github.com/mikefarah/yq/releases/download/${VERSION}/yq_linux_amd64" -O /usr/local/bin/yq
  chmod +x /usr/local/bin/yq
  ```

- Configure automated security updates

  ``` shell
  vi /etc/dnf/automatic.conf
  ```

  ``` text
  [commands]
  upgrade_type = security
  apply_updates = yes
  ```

  ``` shell
  systemctl enable --now dnf-automatic.timer
  systemctl list-timers *dnf-*
  ```

- Prevent laptop from entering hibernate/suspend mode when the lid is closed.

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

- Copy public SSH key for authorization

  ``` shell
  mkdir -p ~/.ssh
  cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
  ```

- Disable password based SSH login

  ``` shell
  vi /etc/ssh/sshd_config
  ```

  ``` text
  PasswordAuthentication no
  ```

- Enable logging for firewalld

  ``` shell
  firewall-cmd --set-log-denied=all
  journalctl -f -l -u firewalld
  ```

- Disable zone drifting for firewalld

  ``` shell
  vi /etc/firewalld/firewalld.conf
  ```

  ``` text
  AllowZoneDrifting=no
  ```
