{ pkgs }:

with pkgs; [
  # core
  jq # json parser
  dust # disk usage
  ouch # zip and unzip
  tree # produce a depth indented directory listing
  parallel # parallelize shell commands
  pkg-config # pkg-config

  # cli tools
  fh # flake generator
  nh # nixos helper
  nom # cli rss reader
  tokei # count code lines
  typos # code spell checker
  nix-init # generate nix pkgs from url
  onefetch # view git repo info
  fastfetch # view system info
  difftastic # diff tool

  bun
  nodejs
  pnpm
  fnm

  python311
  rye
  uv
  ruff

  nixpkgs-fmt

  typst

  rustup

  cmake
  xmake
  llvm_19
  qt6.full
  clang-tools

  selene

  # R&D
  zotero

  # misc
  qq
  pandoc
  quarto
  typora
  obs-studio
  wechat-uos
  qbittorrent
  wpsoffice-cn
  teamspeak5_client

  nur.repos.xddxdd.baidunetdisk
  nur.repos.chillcicada.degit-rs
  nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
]
