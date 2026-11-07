{
  lib,
  osConfig,
  ...
}:

let
  cfg = osConfig.desktop;
  cursor = osConfig.stylix.cursor;

  defaultTheme = ''
    [Icon Theme]
    Name=Default
    Comment=Default Cursor Theme
    Inherits=${cursor.name}
  '';
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "niri") {
    # Xcursor fallback for clients that explicitly ask for the "default" theme.
    # These paths were previously managed by home-manager and still pointed at
    # the old catppuccin cursor theme.
    files.".icons/default/index.theme".text = defaultTheme;
    xdg.data.files."icons/default/index.theme".text = defaultTheme;
  };
}
