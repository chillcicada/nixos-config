{ pkgs, vars, ... }:

{
  # https://nixos.wiki/wiki/Steam
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession.enable = true;

      fontPackages = with pkgs; [
        lxgw-wenkai

        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    adwsteamgtk
    mangohud
  ];

  services.getty.autologinUser = vars.userName;

  hardware.xpadneo.enable = true;
  hardware.graphics.enable32Bit = true;
}
