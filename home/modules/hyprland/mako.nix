{ lib, config, ... }:

let
  cfg = config.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    stylix.targets.mako.enable = false;

    services.mako = {
      enable = true;

      settings = {
        sort = "-time";
        layer = "overlay";
        background-color = "#2e34407f";
        width = "420";
        height = "120";
        border-size = "3";
        border-color = "#99c0d0";
        border-radius = "12";
        icons = "0";
        max-icon-size = "64";
        default-timeout = "5000";
        ignore-timeout = "0";
        font = "Noto Sans CJK SC 14";
        margin = "12";
        padding = "12,20";

        "urgency=low" = {
          border-color = "#cccccc";
        };

        "urgency=normal" = {
          border-color = "#99c0d0";
        };

        "urgency=critical" = {
          border-color = "#bf616a";
          default-timeout = "0";
        };
      };
    };
  };
}
