{ pkgs }:

with pkgs;
[
  # core & utils
  fh # flake generator
  dust # disk usage
  tree # tree view
  tokei # count code lines
  typos # typo correction
  unzip # unzip files
  treefmt # tree format
  parallel # parallelize shell commands
  difftastic # diff tool
  pkg-config # pkg-config
  imagemagick # image manipulation

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
  typstyle # formatter

  # rust
  rustup

  # c/c++
  gcc
  xmake
  clang-tools

  # nix
  nil
  nixfmt-rfc-style # formatter

  # lua
  selene
  stylua
  tree-sitter
  lua51Packages.lua
  luajitPackages.luarocks

  # misc
  qq
  pandoc # required by typora
  typora
  zotero
  wechat-uos
  wpsoffice-cn
  teamspeak5_client
]
++ (with nur.repos; [
  # nur
  chillcicada.typship
  chillcicada.degit-rs
  novel2430.wemeet-bin-bwrap-wayland-screenshare
])
