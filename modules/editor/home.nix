{ pkgs, ... }:

{
  imports = [ ./home ];

  home.packages =
    with pkgs;
    [
      # js/ts
      eslint
      typescript

      # python
      ruff # python linter and formatter

      # typst
      typst
      typstyle # formatter

      # c/c++
      gcc
      xmake
      gnumake # required by neovim

      # nix
      nil # nix linter
      nixfmt-rfc-style # formatter

      # lua & neovim
      selene # lua linter
      stylua # lua formatter
      tree-sitter
      lua51Packages.lua
      luajitPackages.luarocks

      # go
      go # required by neovim

      # toml
      taplo

      # misc
      tokei # count code lines
      treefmt # tree format
    ]
    ++ (with nur.repos; [
      # nur
      chillcicada.typship # tpyst publishing tool
    ]);
}
