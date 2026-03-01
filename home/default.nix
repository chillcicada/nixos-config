{ ... }:

{
  # This configuration is designed for graphical usage.
  imports = [
    # Software enabled for the desktop environment by default
    ./apps
    # Modules for the desktop environment
    ./modules
    # Common configurations with the minimal configurations
    ./common.nix
  ];
}
