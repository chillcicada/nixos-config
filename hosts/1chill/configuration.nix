{
  pkgs,
  inputs,
  vars,
  ...
}:

{
  imports = [
    ../../core
    ./hardware.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-64f9a2a3-e6c3-418c-902d-dde61e57bdb3".device =
    "/dev/disk/by-uuid/64f9a2a3-e6c3-418c-902d-dde61e57bdb3";

  # X11 & GNOME
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.gnome.core-utilities.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-maps
    epiphany # web browser
    gnome-user-docs
    gnome-text-editor
    gnome-music
    gnome-contacts
    gnome-calculator
    gnome-characters
    simple-scan
    yelp # help viewer
    geary # mail client
    totem # video player
    evince # document viewer
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pulseaudio.support32Bit = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    adwaita-icon-theme
    gnomeExtensions.appindicator
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  programs.dconf.enable = true;

  environment.sessionVariables = {
    XMODIFIERS = "@im=fcitx";
    QT_IM_MODULE = "fcitx";
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "25.05";
}
