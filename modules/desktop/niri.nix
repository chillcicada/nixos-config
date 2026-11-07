{
  pkgs,
  lib,
  config,
  vars,
  ...
}:

let
  cfg = config.desktop;
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "niri") {
    programs.niri.enable = true;

    # Desktop shell: bar, launcher, notifications, lock screen, wallpaper, …
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true;
    };

    # Expose the niri session under /run/current-system/sw/share so that greeters
    # can discover it without relying on a login-session XDG_DATA_DIRS.
    environment.pathsToLink = [ "/share/wayland-sessions" ];

    services.displayManager.noctalia-greeter = {
      enable = true;

      cursorTheme = {
        package = config.stylix.cursor.package;
        name = config.stylix.cursor.name;
      };

      settings = {
        session.default = "niri";

        appearance = {
          theme_mode = config.stylix.polarity;
          font_family = config.stylix.fonts.sansSerif.name;

          wallpaper = {
            path = "${config.stylix.image}";
            fill_mode = "crop";
          };
        };

        cursor.size = config.stylix.cursor.size;
        keyboard.layout = config.services.xserver.xkb.layout;
      };
    };

    # Auto-login into niri at boot, mirroring the old GDM autoLogin setup.
    # greetd's initial_session skips the greeter on boot; the greeter is
    # started again once the desktop session exits (logout), like GDM does.
    services.greetd.settings.initial_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = vars.userName;
    };
  };
}
