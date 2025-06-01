{
  pkgs,
  lib,
  vars,
  inputs,
  ...
}:

{
  nix = {
    package = pkgs.nix;
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      use-xdg-base-directories = true;
      trusted-users = [ vars.userName ];
      substituters = [
        "https://cache.nixos.org"

        "https://nix-community.cachix.org"
        "https://chillcicada.cachix.org"
        "https://rewine.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chillcicada.cachix.org-1:nW+OhwrpD0z5oGcBFt/aLEtzN94XcJBm81/cAHsEwVU="
        "rewine.cachix.org-1:aOIg9PvwuSefg59gVXXxGIInHQI9fMpskdyya2xO+7I="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs;
}
