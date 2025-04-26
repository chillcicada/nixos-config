# This file contains the minimal core configuration for a NixOS system.
# No graphical environment is included.

{ vars, ... }:

{
  imports = [
    ./system.nix
  ];

  # nix
  nix = {
    channel.enable = false;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ vars.userName ];
    };
  };

  # locales
  time.timeZone = "Asia/Shanghai";

  # fonts
  fonts.fontconfig.enable = false;
}
