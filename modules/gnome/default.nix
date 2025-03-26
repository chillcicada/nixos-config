{ pkgs, vars, ... }:

{
  # X11 & GNOME
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = with pkgs; [ xterm ];

  services.gnome.core-utilities.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-logs
    gnome-maps
    gnome-tour
    gnome-music
    gnome-contacts
    gnome-user-docs
    gnome-calculator
    gnome-characters
    gnome-font-viewer
    gnome-text-editor

    yelp # help viewer
    geary # mail client
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

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = vars.userName;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages =
    with pkgs;
    [
      gnome-tweaks
    ]
    ++ (with gnomeExtensions; [
      open-bar
      appindicator
    ]);

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.dconf.enable = true;
}
