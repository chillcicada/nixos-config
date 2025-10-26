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

  nixpkgs.overlays = [ inputs.chillcicada.overlays.default ];

  gtk = {
    enable = true;

    gtk2.enable = false;

    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };

    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };
}
