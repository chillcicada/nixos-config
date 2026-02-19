{ ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;

  imports = [
    ./services
    ./hardware.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  fonts.fontconfig.enable = false;

  system.tools.nixos-generate-config.enable = false;

  # Time Zone
  time.timeZone = "Asia/Shanghai";
}
