<h1 align="center">NixOS-config</h1>

<p align="center">
	<a href="https://github.com/chillcicada/nixos-config/stargazers"><img alt="Stargazers" src="https://img.shields.io/github/stars/chillcicada/nixos-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41" /></a>
  <a href="https://nixos.org/"><img alt="NIXOS Version" src="https://img.shields.io/badge/NixOS-Unstable-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41" /></a>
</p>

This repo stores some cc's **nixos and home-manager** configurations.

> Hint: this repo contains my hardware configuration, you shouldn't directly use the config to build your system.

Run `just --list` to see all recipes.

## Structure

```txt
.
├── flake.lock      # the lock file for the flake.
├── flake.nix       # the main entry point of the flake.
├── home            # the home-manager configurations.
│   ├── apps/       # the auto-imported app-specific configurations.
│   ├── modules/    # the reusable modules for home-manager.
│   ├── common.nix  # the common configuration for home-manager.
│   └── default.nix # the default configuration for home-manager.
├── hosts           # the host-specific configurations.
│   ├── <machine>/  # the configurations for a specific machine.
│   ├── default.nix # the import configuration for all hosts.
│   └── vars.nix    # the shared variables used in the host configurations.
├── LICENSE         # the license file.
├── modules/        # the reusable top-level modules for different purposes.
└── README.md       # this file.
```

## Miscellaneous

Below are some miscellaneous notes.

Rebuild and switch the system configuration:

```sh
sudo nixos-rebuild switch --flake ."#$(hostname)" |& nom
```

Rebuild the system configuration but not switch:

```sh
sudo nixos-rebuild boot --flake ."#$(hostname)" |& nom
```

Set a temporary proxy for nix-daemon (superuser permission required):

```sh
#!/usr/bin/env bash
mkdir /run/systemd/system/nix-daemon.service.d
cat > /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="http_proxy=<your_proxy>"
Environment="https_proxy=<your_proxy>"
Environment="all_proxy=<your_proxy>"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
```

Clean the machine:

```sh
sudo nh clean all
```

This nixos config is designed to build remote nixos system on a local machine and push it to the remote machine, use with **ssh config**:

```sh
# Note that it required no sudo permission on the local machine
nixos-rebuild --target-host "<remote-host>" --sudo switch --flake ."#<remote-host>" |& nom
```

With the ssh config like:

```ssh
Host <remote-host>
  User <username>
  Hostname <ip-address/domain>
```

Emergency rollback to the previous boot entry:

```sh
sudo grub-reboot '1>1'
sudo reboot
```

## Other Configurations

- neovim config: [nvim-config](https://github.com/chillcicada/nvim-config)
- typora themes: [typora-themes](https://github.com/chillcicada/typora-themes)
- wallpapers: [wallpapers](https://github.com/chillcicada/imgs)

## License

[GLWTS](LICENSE)
