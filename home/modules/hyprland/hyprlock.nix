{ lib, config, ... }:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
