{
  pkgs,
  vars,
  lib,
  config,
  ...
}:

let
  cfg = config.steam;
in

{
  options.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
    # https://nixos.wiki/wiki/Steam
    programs = {
      steam = {
        enable = true;
        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;
        # Open ports in the firewall for Source Dedicated Server
        dedicatedServer.openFirewall = true;
        # Open ports in the firewall for Steam Local Network Game Transfers
        localNetworkGameTransfers.openFirewall = true;

        fontPackages = with pkgs; [
          lxgw-neoxihei # CJK
          noto-fonts-color-emoji # Emoji
        ];
      };
    };

    environment.systemPackages = with pkgs; [ adwsteamgtk ];

    services.getty.autologinUser = vars.userName;

    hardware.xone.enable = true; # xbox controller support
    hardware.graphics.enable32Bit = true;
  };
}
