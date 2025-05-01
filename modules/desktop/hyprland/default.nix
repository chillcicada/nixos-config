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
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
