{ pkgs, ... }:

# core & utils
with pkgs;
[
  jq # json processor
  dust # disk usage
  tree # tree view
  sops # secrets management
  wget # download files
  unzip # unzip files, required by nvim
  cachix # nix binary cache
  nix-tree # nix tree view
  degit-rs # degit
  difftastic # diff tool
]
