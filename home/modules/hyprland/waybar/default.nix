{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    packages = [ pkgs.waybar ];

    xdg.config.files = {
      "waybar/config.jsonc".source = ./config.jsonc;
      "waybar/style.css".source = ./style.css;
    };
  };
}
