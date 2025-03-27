{ pkgs, ... }:

{
  # required by typora
  programs.pandoc = {
    enable = true;
    package = pkgs.pandoc;
  };
}
