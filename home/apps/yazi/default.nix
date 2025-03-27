{ pkgs, lib, ... }:

{
  # refer to https://yazi-rs.github.io/ for more information
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    settings = lib.importTOML ./yazi.toml;
  };
}
