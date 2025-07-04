{ ... }:

{
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ./apps
    ./modules
    ./common.nix
  ];
}
