{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    packages = [ pkgs.wlogout ];
  };
}
