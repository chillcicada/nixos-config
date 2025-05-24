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
    nil # linter
    nixfmt-rfc-style # formatter

    # python
    (python312.withPackages (
      ps: with ps; [
        requests
      ]
    ))
  ];
}
