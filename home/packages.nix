{ pkgs, ... }:

with pkgs;
[
  # core & utils
  curl # cli http client
  dust # disk usage
  tree # tree view
  wget # download files
  unzip # unzip files, required by nvim
  cachix # nix binary cache
  difftastic # diff tool
]
++ (with nur.repos; [
  # nur
  chillcicada.degit-rs
])
