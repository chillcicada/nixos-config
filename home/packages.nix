{ pkgs, ... }:

with pkgs;
[
  # core & utils
  jq # json processor
  dust # disk usage
  tree # tree view
  sops # secrets management
  wget # download files
  unzip # unzip files, required by nvim
  cachix # nix binary cache
  nix-tree # nix tree view
  difftastic # diff tool
]
++ (with nur.repos; [
  # nur
  chillcicada.degit-rs
])
