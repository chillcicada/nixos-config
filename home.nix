{
  pkgs,
  config,
  vars,
  lib,
  ...
}:

let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  home.username = vars.userName;
  home.homeDirectory = "/home/${vars.userName}";
  home.packages = packages;

  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [ ./apps ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # linked to https://github.com/catppuccin/nix/issues/275
  qt = lib.mkForce {
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
