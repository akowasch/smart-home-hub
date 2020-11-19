# Podman

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
