{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  # alternative to fastfetch
  home.packages = with pkgs; [ ufetch ];

  programs.zsh.shellAliases.f = "ufetch";
}
