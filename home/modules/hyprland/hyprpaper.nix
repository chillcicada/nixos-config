{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    services.hyprpaper = {
      enable = true;
    };
  };
}
