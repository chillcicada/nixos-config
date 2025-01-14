_:

{
  nix = {
    settings = {
      auto-optimise-store = true;
      # Enable experimental features
      experimental-features = [ "nix-command" "flakes" ];
    };

    # Storage optimization
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
