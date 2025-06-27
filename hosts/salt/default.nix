{ inputs, vars, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;

  imports = [
    ./services
    ./hardware.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  # Home Manager Entry
  home-manager.users.${vars.userName}.imports = [ inputs.self.homeModules.salt ];

  # Time Zone.
  time.timeZone = "Asia/Shanghai";
}
