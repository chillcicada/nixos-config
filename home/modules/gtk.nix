{
  lib,
  config,
  osConfig,
  ...
}:

let
  cfg = config.desktop;
  cursor = osConfig.stylix.cursor;

  settings = ''
    [Settings]
    gtk-im-module=fcitx
    gtk-cursor-theme-name=${cursor.name}
    gtk-cursor-theme-size=${toString cursor.size}
  '';
in

{
  config = lib.mkIf cfg.enable {
    # GTK 3 and 4 only; GTK 2 is intentionally not configured.
    xdg.config.files = {
      "gtk-3.0/settings.ini".text = settings;
      "gtk-4.0/settings.ini".text = settings;
    };
  };
}
