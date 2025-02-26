#!/usr/bin/env bash
mkdir /run/systemd/system/nix-daemon.service.d
cat << EOF >/run/systemd/system/nix-daemon.service.d/override.conf
[Service]
Environment="http_proxy=http://localhost:7897"
Environment="https_proxy=http://localhost:7897"
Environment="all_proxy=socks5://localhost:7897"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
