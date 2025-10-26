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
    # Build Coreutils
    environment.systemPackages = with pkgs; [
      git
      just
      gnupg
      nix-output-monitor # nom
    ];

    programs.gnupg.agent.enable = true;

    # Build Source
    nix = {
      registry.nixpkgs.flake = inputs.nixpkgs;
      settings = {
        nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
        substituters = [
          "https://cache.nixos.org"

          "https://nix-community.cachix.org"
          "https://chillcicada.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "chillcicada.cachix.org-1:nW+OhwrpD0z5oGcBFt/aLEtzN94XcJBm81/cAHsEwVU="
        ];
      };
    };

    environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs;
  };
}
