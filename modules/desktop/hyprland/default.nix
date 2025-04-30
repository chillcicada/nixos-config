{ pkgs, vars, ... }:

{

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      excludePackages = with pkgs; [ xterm ];

      xkb = {
        layout = "us";
      };
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = vars.userName;
      };
    };
  };

  programs.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  settings = {
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$menu" = "fuzzel";

    exec-once = [
      "fcitx5"
    ];
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    hyprshot # screenshot tool
    hyprlock # lock screen
    fuzzel
    wofi
    waybar
    hyprpaper # wallpaper manager
    waypaper
    wlogout
    dunst
    hyprshade
    hypridle
    hyprcursor
    hyprpicker
  ];
}
