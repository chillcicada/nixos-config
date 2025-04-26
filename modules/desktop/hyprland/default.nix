{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;

    xwayland.enable = true;

    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  programs.dconf.enable = true;
}
