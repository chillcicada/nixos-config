{ pkgs, ... }:

{
  programs.nh = {
    enable = true;
    package = pkgs.nh;
  };
}
