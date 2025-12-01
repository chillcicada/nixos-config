{ inputs, ... }:

{
  # This configuration is designed for graphical usage (`desktop.enable = true`).
  imports = [
    # Software enabled by default
    ./apps
    # Modules for the desktop environment
    ./modules
    # Common configurations with Minimal configurations
    ./common.nix
  ];

  # Add nixpkgs overlays
  nixpkgs.overlays = [ inputs.chillcicada.overlays.default ];
}
