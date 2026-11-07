{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    packages = [ pkgs.hyprpaper ];

    xdg.config.files."hypr/hyprpaper.conf".text = ''
      splash = false
      preload = ${osConfig.stylix.image}
      wallpaper = ,${osConfig.stylix.image}
    '';
  };
}
