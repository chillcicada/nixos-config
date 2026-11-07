{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.hyprland;

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

  formatValue = v: if builtins.isBool v then (if v then "true" else "false") else toString v;

  globalSettings = lib.filterAttrs (_: v: !(lib.isAttrs v)) settings;
  sectionSettings = lib.filterAttrs (_: v: lib.isAttrs v) settings;

  generateConfig =
    lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "${k}=${formatValue v}") globalSettings)
    + lib.optionalString (sectionSettings != { }) (
      "\n"
      + lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          name: attrs:
          "\n[${name}]\n"
          + lib.concatStringsSep "\n" (lib.mapAttrsToList (k: v: "${k}=${formatValue v}") attrs)
        ) sectionSettings
      )
    );
in

{
  config = lib.mkIf cfg.enable {
    packages = [ pkgs.mako ];

    xdg.config.files."mako/config".text = generateConfig;
  };
}
