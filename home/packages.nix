{ pkgs, ... }:

with pkgs;
[
  # core & utils
  dust # disk usage
  tree # tree view
  sops # secrets management
  wget # download files
  unzip # unzip files, required by nvim
  cachix # nix binary cache
  nix-tree
  difftastic # diff tool
]
++ (with nur.repos; [
  # nur
  chillcicada.degit-rs
])
