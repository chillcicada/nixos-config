{ lib, config, ... }:

{
  config = lib.mkIf config.hyprland.enable {
    programs.fuzzel = {
      enable = true;
    };
  };
}
