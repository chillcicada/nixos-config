{ lib, config, ... }:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    stylix.targets.waybar.enable = false;

    programs.waybar = {
      enable = true;

      style = builtins.readFile ./style.css;
    };

    home.file.".config/waybar/config.jsonc".source = ./config.jsonc;
  };
}
