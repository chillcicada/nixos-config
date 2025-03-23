{ pkgs }:

with pkgs;
[
  # core & utils
  fh # flake generator
  curl # cli http client
  dust # disk usage
  tree # tree view
  wget # download files
  tokei # count code lines
  typos # typo correction
  unzip # unzip files, required by nvim
  treefmt # tree format
  parallel # parallelize shell commands
  difftastic # diff tool
  pkg-config # pkg-config, required by rust
  imagemagick # image manipulation

  # js/ts
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
  clang-tools # provides clangd and clang-format

  # nix
  nil
  nixfmt-rfc-style # formatter

  # lua
  selene
  stylua
  tree-sitter # required by nvim
  lua51Packages.lua
  luajitPackages.luarocks

  # misc
  qq
  typora
  zotero
  wechat-uos
  teamspeak5_client
]
++ (with nur.repos; [
  # nur
  chillcicada.typship
  chillcicada.degit-rs
  chillcicada.wpsoffice-cn
  novel2430.wemeet-bin-bwrap-wayland-screenshare
])
