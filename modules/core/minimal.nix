{ ... }:

{
  imports = [
    ./nix.nix
    ./system.nix
    ./nixpkgs.nix
  ];

  # locales
  time.timeZone = "Asia/Shanghai";

  # fonts
  fonts.fontconfig.enable = false;
}
