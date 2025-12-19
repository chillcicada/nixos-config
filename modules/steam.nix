{
  pkgs,
  vars,
  lib,
  config,
  ...
}:

let
  cfg = config.steam;

  patchDesktop =
    pkg: appName: from: to:
    lib.hiPrio (
      pkgs.runCommand "$patched-desktop-entry-for-${appName}" { } ''
        mkdir -p $out/share/applications
        sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      ''
    );

  GPUOffloadApp =
    pkg: desktopName:
    lib.mkIf config.hardware.nvidia.prime.offload.enable (
      patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload "
    );
in

{
  options.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
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
          lxgw-neoxihei # CJK
          noto-fonts-color-emoji # Emoji
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      adwsteamgtk
      mangohud

      # desktop applications patched for GPU offloading
      (GPUOffloadApp steam "steam")
    ];

    services.getty.autologinUser = vars.userName;

    hardware.xpadneo.enable = true; # xbox controller support
    hardware.graphics.enable32Bit = true;
  };
}
