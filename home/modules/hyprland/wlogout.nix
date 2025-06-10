{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}
