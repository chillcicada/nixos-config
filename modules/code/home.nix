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
      ruff
      python311

      # typst
      typst

      # rust
      rustup

      # c/c++
      gcc
      xmake

      # nix
      nil # nix linter
      nixfmt-rfc-style # formatter
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
