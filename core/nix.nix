{ vars
, ...
}:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;
      trusted-users = [ vars.userName ];
      substituters = [
        "https://cache.nixos.org"
        "https://cuda-maintainers.cachix.org"
        "https://nix-community.cachix.org"
        "https://chillcicada.cachix.org"
      ];
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "chillcicada.cachix.org-1:nW+OhwrpD0z5oGcBFt/aLEtzN94XcJBm81/cAHsEwVU="
      ];
    };

    channel = {
      enable = false;
    };

    # Storage optimization
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
