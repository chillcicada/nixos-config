# NixOS-config

<p align="center"><img src="https://img.chillcicada.com/i/2025/03/26/67e3884a2de6d.png" width=300px></p>

This repo stores some cc's NixOS-configs.

> Hint: this repo contains my hardware configuration, you shouldn't directly use the config to build your system.

Run `just --list` to see all reciipes.

Below are some miscellaneous notes.

---

Set a temporary proxy for nix-daemon

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

## License

[GLWTS](LICENSE)
