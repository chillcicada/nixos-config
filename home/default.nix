{
  pkgs,
  inputs,
  vars,
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
}
