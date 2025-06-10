{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    services.hypridle = {
      enable = true;
    };
  };
}
