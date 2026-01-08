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
    services = {
      desktopManager.gnome.enable = true;

      gnome = {
        rygel.enable = true;
        sushi.enable = true;
        tinysparql.enable = true;
        core-shell.enable = true;
        localsearch.enable = true;
        gnome-keyring.enable = true;
        core-os-services.enable = true;

        games.enable = lib.mkForce false;
        core-apps.enable = lib.mkForce false;
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

    environment.systemPackages =
      with pkgs;
      [
        nautilus # File manager
        snapshot # Camera app
        gnome-system-monitor # System monitor
        gnome-control-center # Settings app
      ]
      ++ (with gnomeExtensions; [
        caffeine
        kimpanel
        open-bar
        appindicator
        blur-my-shell
        system-monitor
        applications-menu
        clipboard-indicator
      ]);
  };
}
