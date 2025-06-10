{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
