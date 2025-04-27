{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # HMCL - Minecraft Launcher
    hmcl
  ];
}
