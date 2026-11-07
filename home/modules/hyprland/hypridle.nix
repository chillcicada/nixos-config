{ lib, config, ... }:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    rum.programs.hypridle = {
      enable = true;
    };
  };
}
