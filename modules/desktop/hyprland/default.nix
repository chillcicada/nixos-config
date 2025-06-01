{ pkgs, vars, ... }:

{
  services = {
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = vars.userName;
      };
    };

    xserver = {
      enable = true;
      excludePackages = with pkgs; [ xterm ];

      xkb = {
        layout = "us";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
