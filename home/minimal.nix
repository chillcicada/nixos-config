{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [ ufetch ];

  home.shellAliases.f = "ufetch";
}
