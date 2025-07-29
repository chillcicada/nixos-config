{ lib, config, ... }:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    programs.wlogout = {
      enable = true;
    };
  };
}
