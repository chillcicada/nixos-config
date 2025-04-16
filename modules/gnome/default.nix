{
  pkgs,
  vars,
  lib,
  ...
}:

{
  # X11 & GNOME
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = with pkgs; [ xterm ];

      xkb = {
        layout = "us";
      };
    };

    gnome = {
      core-utilities.enable = true;

      games.enable = false;
      gnome-user-share.enable = false;
      gnome-initial-setup.enable = false;
      gnome-remote-desktop.enable = false;
      gnome-online-accounts.enable = false;
      gnome-browser-connector.enable = false;
      evolution-data-server.enable = lib.mkForce false;
    };

    # Enable automatic login for the user.
    displayManager = {
      autoLogin = {
        enable = true;
        user = vars.userName;
      };
    };

    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-logs
    gnome-maps
    gnome-tour
    gnome-music
    gnome-clocks
    gnome-console
    gnome-weather
    gnome-calendar
    gnome-contacts
    gnome-software
    gnome-terminal
    gnome-user-docs
    gnome-calculator
    gnome-characters
    gnome-font-viewer
    gnome-text-editor
    gnome-disk-utility

    orca # screen reader
    tali # task manager
    yelp # help viewer
    geary # mail client
    iagno # solitaire
    totem # video player
    baobab # disk usage analyzer
    evince # document viewer
    epiphany # web browser
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

  environment.systemPackages =
    with pkgs;
    [
      gnome-tweaks
    ]
    ++ (with gnomeExtensions; [
      forge
      caffeine
      kimpanel
      open-bar
      appindicator
      blur-my-shell
      app-menu-is-back
      battery-health-charging
    ]);

  programs.dconf.enable = true;
}
