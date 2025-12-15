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
├── flake.lock
├── flake.nix
├── home
│   ├── apps/
│   ├── modules/
│   ├── common.nix
│   ├── default.nix
│   └── minimal.nix
├── hosts
│   ├── <machine>/
│   ├── default.nix
│   └── vars.nix
├── justfile
├── LICENSE
├── modules/
├── README.md
└── treefmt.toml
```

A brief description of the structure:

- `flake.lock`: the lock file for the flake.
- `flake.nix`: the main entry point of the flake.
- `home`: the home-manager configurations.
  - `apps`: the auto-imported app-specific configurations.
  - `modules`: the reusable modules for home-manager.
  - `common.nix`: the common configuration for home-manager.
  - `default.nix`: the default configuration for home-manager.
  - `minimal.nix`: the minimal configuration for home-manager.
- `hosts`: the host-specific configurations.
  - `<machine>`: the configurations for a specific machine.
  - `default.nix`: the import configuration for all hosts.
  - `vars.nix`: the shared variables used in the host configurations.
- `justfile`: the file that contains the recipes for the `just` command.
- `LICENSE`: the license file.
- `modules`: contains the reusable top-level modules for different purposes.
- `README.md`: this file.
- `treefmt.toml`: the configuration file for `treefmt`, used to format the repo.

## Miscellaneous

Below are some miscellaneous notes.

---

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

Format the repo:

```sh
treefmt
```

Clean the machine:

```sh
nh clean all
```

Get the dependency graph of a package (`nix-tree` and `ripgrep` is required):

```sh
nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree
```

Then type `/` and the package name to get the dependency graph.

This nixos config is designed to build remote nixos system on a local machine, use:

```sh
just push <remote-host>
```

Here the `<remote-host>` is the hostname of the remote machine, which is defined in the **ssh config**, and the recipe is a wrapper of the following command:

```sh
nixos-rebuild --target-host {{TARGET}} --use-remote-sudo switch --flake
```

Here `{{TARGET}}` is `<remote-host>`, with a ssh config like:

```ssh
Host <remote-host>
  User <username>
  Hostname <ip-address/domain>
```

## Other Configurations

- neovim config: [nvim-config](https://github.com/chillcicada/nvim-config)
- typora themes: [typora-themes](https://github.com/chillcicada/typora-themes)
- wallpapers: [wallpapers](https://github.com/chillcicada/imgs)

## License

[GLWTS](LICENSE)
