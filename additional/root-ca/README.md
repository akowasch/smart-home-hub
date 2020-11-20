# Root-CA

<https://github.com/smallstep/cli>

- Download step cli

  ``` shell
  # macOS
  brew install step

  # Debian Linux
  VERSION=0.15.3
  wget "https://github.com/smallstep/cli/releases/download/v0.15.3/step-cli_${VERSION}_amd64.deb"
  sudo dpkg -i "step-cli_${VERSION}_amd64.deb"

  # Arch Linux
  pacman -S step-cli

  # Other Linux
  VERSION=0.15.3
  wget -c "https://github.com/smallstep/cli/releases/download/v${VERSION}/step_linux_${VERSION}_amd64.tar.gz" -O - | tar -xzvf - --strip-components 2 -C /usr/local/bin/ "step_${VERSION}/bin/step"
  chmod +x /usr/local/bin/step
  ```

- Create root-ca certificate

  ``` shell
  step certificate create root-ca root-ca.crt root-ca.key \
    --profile root-ca \
    --kty RSA \
    --size 4096
  ```
