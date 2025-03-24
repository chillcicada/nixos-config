{
  pkgs,
  inputs,
  vars,
  lib,
  ...
}:

let
  packages = import ./packages.nix { inherit inputs pkgs; };
in
{
  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
    packages = packages;
    stateVersion = "25.05";
  };

  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [ ./apps ];

  programs.home-manager.enable = true;

  # linked to https://github.com/catppuccin/nix/issues/275
  qt = lib.mkForce {
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
