{ inputs, vars, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;

  imports = [
    ../../modules/core/minimal.nix

    ./services
    ./hardware.nix
    ./networking.nix
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  home-manager.users.${vars.userName}.imports = [ inputs.self.homeModules.salt ];
}
