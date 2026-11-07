{
  lib,
  osConfig,
  ...
}:

let
  cfg = osConfig.desktop;
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "niri") {
    rum.desktops.niri = {
      enable = true;

      config = ''
        cursor {
            xcursor-theme "${osConfig.stylix.cursor.name}"
            xcursor-size ${toString osConfig.stylix.cursor.size}
        }
      ''
      + builtins.readFile ./config.kdl;

      extraVariables = {
        # Cursor theme from stylix
        XCURSOR_THEME = osConfig.stylix.cursor.name;
        XCURSOR_SIZE = osConfig.stylix.cursor.size;
      };
    };
  };
}
