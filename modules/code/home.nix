{ pkgs, ... }:

{
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

      # nix
      nil # nix linter
      nixfmt-rfc-style # formatter

      # lua
      selene # lua linter
      stylua # lua formatter

      # misc
      tokei # count code lines
      treefmt # tree format
    ]
    ++ (with nur.repos; [
      # nur
      chillcicada.typship
    ]);

  # js/ts
  programs.bun = {
    enable = true;
    package = pkgs.bun;

    enableGitIntegration = true;

    # refer to https://bun.sh/docs/runtime/bunfig
    settings = {
      smol = true;
    };
  };
}
