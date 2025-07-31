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

  # Disable font config
  fonts.fontconfig.enable = false;

  # Time Zone
  time.timeZone = "Asia/Shanghai";
}
