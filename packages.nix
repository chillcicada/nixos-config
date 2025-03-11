{ pkgs }:

with pkgs; [
  # core
  dust # disk usage
  ouch # zip and unzip
  tree # produce a depth indented directory listing
  parallel # parallelize shell commands
  pkg-config # pkg-config
  imagemagick # image manipulation

  # cli tools
  fh # flake generator
  nh # nixos helper
  tokei # count code lines
  onefetch # view git repo info
  fastfetch # view system info
  difftastic # diff tool

  bun
  nodejs
  pnpm

  python311
  rye
  uv
  ruff

  typst

  rustup

  gcc
  xmake
  clang-tools

  nixpkgs-fmt

  selene
  stylua
  tree-sitter
  lua51Packages.lua
  luajitPackages.luarocks

  # misc
  qq
  pandoc
  typora
  zotero
  wechat-uos
  wpsoffice-cn
  teamspeak5_client

  nur.repos.chillcicada.typship
  nur.repos.chillcicada.degit-rs
  nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
]
