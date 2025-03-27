{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    package = pkgs.eza;
    git = true;
    icons = "auto";
  };
}
