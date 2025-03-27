{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    package = pkgs.btop;
    settings = {
      theme_background = false;
    };
  };
}
