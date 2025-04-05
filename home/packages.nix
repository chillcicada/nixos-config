{ inputs, pkgs, ... }:

[ inputs.zen-browser.packages."${pkgs.system}".default ]
++ (
  with pkgs;
  [
    # core & utils
    curl # cli http client
    dust # disk usage
    tree # tree view
    wget # download files
    tokei # count code lines
    unzip # unzip files, required by nvim
    cachix # nix binary cache
    treefmt # tree format
    difftastic # diff tool

    # lua & neovim
    selene # lua linter
    stylua # lua formatter
    tree-sitter # required by nvim
    lua51Packages.lua
    luajitPackages.luarocks

    # misc
    typora
  ]
  ++ (with nur.repos; [
    # nur
    chillcicada.typship
    chillcicada.degit-rs
  ])
)
