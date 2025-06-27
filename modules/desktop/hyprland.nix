{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.desktop;
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "hyprland") {
    # Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}
