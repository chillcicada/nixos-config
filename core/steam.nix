{
  pkgs,
  config,
  vars,
  ...
}:

{
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
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
      ];
    };
  };

  environment.systemPackages = with pkgs; [ adwsteamgtk ];

  hardware.xone.enable = true; # support for the xbox controller USB dongle
  services.getty.autologinUser = vars.userName;
}
