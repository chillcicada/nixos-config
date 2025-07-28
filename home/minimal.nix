{ pkgs, ... }:

{
  # Minimal configurations without GUI
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ ufetch ];

  home.shellAliases.f = "ufetch";
}
