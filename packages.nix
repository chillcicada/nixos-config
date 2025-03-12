{ pkgs }:

with pkgs; [
  # core
  dust # disk usage
  ouch # zip and unzip
  tree # produce a depth indented directory listing
  parallel # parallelize shell commands
  pkg-config # pkg-config
  imagemagick # image manipulation

  # utils
  fh # flake generator
  tokei # count code lines
  onefetch # view git repo info
  difftastic # diff tool

  # js/ts
  bun
  pnpm
  nodejs

  # python
  uv
  rye
  ruff
  python311

  # typst
  typst
  typstyle

  # rust
  rustup

  # c/c++
  gcc
  xmake
  clang-tools

  # nix
  nil
  nixpkgs-fmt

  # lua
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
] ++ (with nur.repos; [
  # nur
  chillcicada.typship
  chillcicada.degit-rs
  novel2430.wemeet-bin-bwrap-wayland-screenshare
])
