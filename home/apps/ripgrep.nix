{ pkgs, ... }:

{
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;
  };
}
