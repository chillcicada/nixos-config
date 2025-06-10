{
  pkgs,
  vars,
  lib,
  config,
  ...
}:

{
  options = {
    steam.enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf config.steam.enable {
    # https://nixos.wiki/wiki/Steam
    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };

      steam = {
        enable = true;
        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;
        # Open ports in the firewall for Source Dedicated Server
        dedicatedServer.openFirewall = true;
        # Open ports in the firewall for Steam Local Network Game Transfers
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;

        fontPackages = with pkgs; [
          ipafont # Japanese
          wqy_zenhei # Chinese
          noto-fonts-color-emoji # Emoji
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      adwsteamgtk
      mangohud
    ];

    services.getty.autologinUser = vars.userName;

    hardware.xpadneo.enable = true; # xbox controller support
    hardware.graphics.enable32Bit = true;
  };
}
