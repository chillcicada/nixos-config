{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # js/ts
    pnpm
    nodejs

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
  ];
}
