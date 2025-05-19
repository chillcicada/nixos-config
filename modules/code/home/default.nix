{ pkgs, ... }:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  home.packages = with pkgs; [
    # js/ts
    pnpm
    nodejs

    # python
    uv
    python312

    # rust
    rustup
  ];
}
