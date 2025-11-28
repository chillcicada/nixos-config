{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.desktop;
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "gnome") {
    # GNOME
    services = {
      desktopManager.gnome.enable = true;

      gnome = {
        rygel.enable = true;
        sushi.enable = true;
        tinysparql.enable = true;
        localsearch.enable = true;

        games.enable = lib.mkForce false;
        core-apps.enable = lib.mkForce false;
        gnome-keyring.enable = lib.mkForce false;
        gnome-user-share.enable = lib.mkForce false;
        gnome-initial-setup.enable = lib.mkForce false;
        core-developer-tools.enable = lib.mkForce false;
        gnome-remote-desktop.enable = lib.mkForce false;
        gnome-online-accounts.enable = lib.mkForce false;
        evolution-data-server.enable = lib.mkForce false;
        gnome-browser-connector.enable = lib.mkForce false;
      };
    };

    environment.gnome.excludePackages = with pkgs; [ gnome-tour ];

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gnome
        ];
      };
    };

    environment.systemPackages =
      with pkgs;
      [
        mutter
        nautilus
        snapshot
        gnome-shell
        gnome-session
        gnome-system-monitor
        gnome-control-center
      ]
      ++ (with gnomeExtensions; [
        caffeine
        kimpanel
        open-bar
        appindicator
        blur-my-shell
        system-monitor
        applications-menu
      ]);

    programs.dconf.enable = true;
  };
}
