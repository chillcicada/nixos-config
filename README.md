<h1 align="center">NixOS-config</h1>

<p align="center">
	<a href="https://github.com/chillcicada/nixos-config/stargazers"><img alt="Stargazers" src="https://img.shields.io/github/stars/chillcicada/nixos-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41" /></a>
  <a href="https://nixos.org/"><img alt="NIXOS Version" src="https://img.shields.io/badge/NixOS-25.11-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41" /></a>
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
│   ├── apps/
│   ├── default.nix
│   ├── minimal.nix
│   └── packages.nix
├── hosts
│   ├── chill
│   │   ├── default.nix
│   │   ├── hardware.nix
│   │   ├── home.nix
│   │   ├── networking.nix
│   │   └── nvidia.nix
│   ├── salt
│   │   ├── default.nix
│   │   ├── hardware.nix
│   │   ├── networking.nix
│   │   ├── secrets.yaml
│   │   └── services/
│   ├── default.nix
│   └── vars.nix
├── justfile
├── LICENSE
├── modules
│   ├── code
│   │   └── home/
│   ├── core
│   │   ├── default.nix
│   │   ├── font.nix
│   │   ├── input.nix
│   │   ├── locale.nix
│   │   ├── minimal.nix
│   │   ├── nix.nix
│   │   └── system.nix
│   ├── desktop
│   │   ├── gnome
│   │   │   ├── default.nix
│   │   │   └── home/
│   │   └── hyprland
│   │       ├── default.nix
│   │       └── home/
│   ├── editor
│   │   └── home/
│   └── graphics
│       ├── default.nix
│       ├── home/
│       └── steam.nix
├── README.md
└── treefmt.toml
```

A brief description of the structure:

- `flake.nix`: the main entry point of the flake.
- `flake.lock`: the lock file for the flake.
- `hosts`: contains the host-specific configurations.
  - `vars.nix`: contains the variables used in the host configurations.
  - `default.nix`: the default configuration for all hosts.
- `modules`: contains the reusable modules for different purposes.
  - `core`: contains the core modules for the system.
  - `desktop`: contains the desktop environment modules, like `gnome` and `hyprland`.
  - `code`: contains the code-related modules.
  - `editor`: contains the editor modules.
  - `graphics`: contains the graphics app modules.
- `home`: contains the home-manager configurations.
  - `apps`: contains the app-specific configurations.
- `treefmt.toml`: the configuration file for `treefmt`, a tool to format the directory tree.
- `justfile`: the file that contains the recipes for the `just` command.
- `LICENSE`: the license file for the repo.
- `README.md`: this file.

## Miscellaneous

Below are some miscellaneous notes.

---

Set a temporary proxy for nix-daemon:

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

Get the dependency graph of a package:

```sh
nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree
```

Then type `/` and the package name to get the dependency graph.

This nixos config is designed to build remote nixos system on a local machine, use

```sh
just push <remote-host>
```

Here the `<remote-host>` is the hostname of the remote machine, which is defined in the **ssh config**, and the recipe is a wrapper of the following command:

```sh
nixos-rebuild --target-host {{TARGET}} --use-remote-sudo switch --flake
```

## Other Configs

- neovim config: [nvim-config](https://github.com/chillcicada/nvim-config)
- typora themes: [typora-themes](https://github.com/chillcicada/typora-themes)
- wallpapers: [wallpapers](https://github.com/chillcicada/imgs)

## License

[GLWTS](LICENSE)
