{ inputs, vars, ... }:

{
  imports = [
    ./docker.nix
    ./hardware.nix
    ./networking.nix

    ../../modules/core/minimal.nix
  ];

  boot.tmp.cleanOnBoot = true;

  zramSwap.enable = true;

  home-manager.users.${vars.userName}.imports = [ inputs.self.homeModules.salt ];
}
