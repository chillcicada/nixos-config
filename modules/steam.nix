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
        gamescopeSession.enable = config.desktop.wm != "gnome";

        fontPackages = with pkgs; [
          lxgw-neoxihei # CJK
          noto-fonts-color-emoji # Emoji
        ];
      };
    }
    // lib.optionalAttrs (config.desktop.wm != "gnome") {
      gamescope = {
        enable = true;
        capSysNice = true;
      };
    };

    environment.systemPackages = with pkgs; [ adwsteamgtk ];

    services.getty.autologinUser = vars.userName;

    hardware.xpadneo.enable = true; # xbox controller support
    hardware.graphics.enable32Bit = true;
  };
}
