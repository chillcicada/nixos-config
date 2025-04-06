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

  # lua & neovim
  tree-sitter # required by nvim
  lua51Packages.lua
  luajitPackages.luarocks
]
++ (with nur.repos; [
  # nur
  chillcicada.degit-rs
])
