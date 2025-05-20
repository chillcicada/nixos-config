{ pkgs, ... }:

{
  imports = map (name: ./${name}) (
    builtins.attrNames (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
  );

  home.packages = with pkgs; [
    tokei # count code lines
    treefmt # tree format
  ];
}
