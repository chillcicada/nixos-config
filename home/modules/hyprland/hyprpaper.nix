{ lib, config, ... }:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
    };
  };
}
