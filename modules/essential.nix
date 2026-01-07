{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

let
  cfg = config.essential;
in

{
  options.essential = {
    enable = lib.mkEnableOption "essential";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnupg ];

    programs.gnupg.agent.enable = true;

    nix = {
      settings = {
        nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
        substituters = [
          "https://nixpkgs-update-cache.nix-community.org"
          "https://nix-community.cachix.org"
          "https://chillcicada.cachix.org"
          "https://cache.nixos.org"
        ];
        trusted-public-keys = [
          "nixpkgs-update-cache.nix-community.org-1:U8d6wiQecHUPJFSqHN9GSSmNkmdiFW7GW7WNAnHW0SM="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "chillcicada.cachix.org-1:nW+OhwrpD0z5oGcBFt/aLEtzN94XcJBm81/cAHsEwVU="
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };
    };

    environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs;
  };
}
