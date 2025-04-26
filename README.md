# NixOS-config

<p align="center"><img src="https://img.chillcicada.com/i/2025/04/19/68030a566a60e.png" width=300px></p>

<p align="center">
	<a href="https://github.com/chillcicada/nixos-config/stargazers">
		<img alt="Stargazers" src="https://img.shields.io/github/stars/chillcicada/nixos-config?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41">
  </a>
  <a href="https://nixos.org/">
    <img src="https://img.shields.io/badge/NixOS-25.05-informational.svg?style=for-the-badge&logo=nixos&color=F2CDCD&logoColor=D9E0EE&labelColor=302D41">
  </a>
</p>

This repo stores some cc's **nixos and home-manager** configurations.

> Hint: this repo contains my hardware configuration, you shouldn't directly use the config to build your system.

Run `just --list` to see all recipes.

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

Here the `<remote-host>` is the hostname of the remote machine, which is defined in ssh config, and the recipe is a wrapper of the following command:

```sh
nixos-rebuild --target-host {{TARGET}} --use-remote-sudo switch --flake
```

## License

[GLWTS](LICENSE)
