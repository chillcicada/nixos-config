# NixOS-config

<p align="center"><img src="https://img.chillcicada.com/i/2025/04/19/68030a566a60e.png" width=300px></p>

This repo stores some cc's NixOS-configs.

> Hint: this repo contains my hardware configuration, you shouldn't directly use the config to build your system.

Run `just --list` to see all recipes.

Below are some miscellaneous notes.

---

Set a temporary proxy for nix-daemon:

```bash
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

```bash
treefmt
```

Clean your machine:

```bash
nh clean all
```

Get the dependency graph of a package:

```bash
nix-store --gc --print-roots | rg -v '/proc/' | rg -Po '(?<= -> ).*' | xargs -o nix-tree
```

Then type `/` and the package name to get the dependency graph.

## License

[GLWTS](LICENSE)
