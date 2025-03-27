{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
  };
}
