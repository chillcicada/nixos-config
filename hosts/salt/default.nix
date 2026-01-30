{ ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;

  imports = [
    ./services
    ./hardware.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;

  # Disable unused nixos tools
  # system.tools.nixos-version.enable = false;
  # system.tools.nixos-rebuild.enable = true;
  # system.tools.nixos-option.enable = false;
  # system.tools.nixos-install.enable = false;
  # system.tools.nixos-generate-config.enable = false;
  # system.tools.nixos-enter.enable = false;
  # system.tools.nixos-build-vms.enable = false;

  zramSwap.enable = true;

  # Disable font config
  fonts.fontconfig.enable = false;

  # Time Zone
  time.timeZone = "Asia/Shanghai";
}
