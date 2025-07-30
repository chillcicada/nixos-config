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
        core-apps.enable = true;

        games.enable = false;
        gnome-user-share.enable = false;
        gnome-initial-setup.enable = false;
        gnome-remote-desktop.enable = false;
        gnome-online-accounts.enable = false;
        gnome-browser-connector.enable = false;

        gnome-keyring.enable = lib.mkForce false;
        evolution-data-server.enable = lib.mkForce false;
      };

      udev.packages = [ pkgs.gnome-settings-daemon ];

      # for nautilus trash
      gvfs.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-logs
      gnome-maps
      gnome-tour
      gnome-music
      gnome-clocks
      gnome-console
      gnome-keyring
      gnome-weather
      gnome-calendar
      gnome-contacts
      gnome-software
      gnome-terminal
      gnome-user-docs
      gnome-calculator
      gnome-characters
      gnome-connections
      gnome-backgrounds
      gnome-font-viewer
      gnome-text-editor
      gnome-disk-utility

      orca # screen reader
      yelp # help viewer
      geary # mail client
      loupe # image viewer
      iagno # solitaire
      totem # video player
      baobab # disk usage analyzer
      evince # document viewer
      decibels # audio player
      epiphany # web browser
      seahorse # password and encryption keys manager
      simple-scan # scanner
    ];

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

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    environment.systemPackages = with pkgs.gnomeExtensions; [
      forge
      caffeine
      kimpanel
      open-bar
      appindicator
      blur-my-shell
      system-monitor
      app-menu-is-back
      applications-menu
    ];

    programs.dconf.enable = true;
  };
}
