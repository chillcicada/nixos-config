{ pkgs, ... }:

{
  imports = [ ./home ];

  home.packages =
    with pkgs;
    [
      # js/ts
      pnpm
      eslint
      nodejs
      typescript

      # python
      uv
      ruff # python linter and formatter
      python312

      # typst
      typst
      typstyle # formatter

      # rust
      rustup

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
      tree-sitter # required by nvim
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
