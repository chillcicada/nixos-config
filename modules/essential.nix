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

    nix.settings = {
      substituters = [
        "https://nixpkgs-update-cache.nix-community.org"
        "https://nix-community.cachix.org"
        "https://chillcicada.cachix.org"
      ];
      trusted-public-keys = [
        "nixpkgs-update-cache.nix-community.org-1:U8d6wiQecHUPJFSqHN9GSSmNkmdiFW7GW7WNAnHW0SM="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chillcicada.cachix.org-1:nW+OhwrpD0z5oGcBFt/aLEtzN94XcJBm81/cAHsEwVU="
      ];
    };
  };
}
