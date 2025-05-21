{ pkgs, ... }:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  home.packages = with pkgs; [
    # js/ts
    pnpm
    eslint
    nodejs

    # typst
    typst

    # c/c++
    gcc
    xmake

    # nix
    nil # nix linter
    nixfmt-rfc-style # formatter

    # python
    uv
    ruff # python linter and formatter
    (python312.withPackages (
      ps: with ps; [
        requests
      ]
    ))
  ];
}
