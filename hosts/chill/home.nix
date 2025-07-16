{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  patchDesktop =
    pkg: appName: from: to:
    lib.hiPrio (
      pkgs.runCommand "$patched-desktop-entry-for-${appName}" { } ''
        ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
        ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      ''
    );

  # add __GL_THREADED_OPTIMIZATIONS=0 to disable threaded optimizations for nvidia-offload, used by minecraft
  nvidia-offload-no-opt = pkgs.writeShellScriptBin "nvidia-offload-no-opt" ''
    __GL_THREADED_OPTIMIZATIONS=0 nvidia-offload "$@"
  '';

  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";

  GPUOffloadAppNoOpt =
    pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload-no-opt ";
in

{
  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

  # -------------------- #
  # self defined options #
  # -------------------- #

  # region cli
  tools.enable = true;
  coreutils.enable = true;

  cpp.enable = true;
  typst.enable = true;
  python.enable = true;
  nixlang.enable = true;
  frontend.enable = true;
  # endregion

  # region gui
  fcitx5.enable = true;
  vscode.enable = true;
  neovim.enable = true;
  graphics.enable = true;

  im.enable = true;
  office.enable = true;
  # endregion

  # ----------- #
  # font config #
  # ----------- #
  stylix.targets.fontconfig.enable = false;

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      serif = [
        "Georgia"
        "Noto Serif CJK SC"
      ];
      sansSerif = [
        "Arial"
        "Noto Sans CJK SC"
      ];
      monospace = [ "Maple Mono NF CN" ];
    };
  };

  # ------------------- #
  # additional packages #
  # ------------------- #

  home.packages =
    [
      nvidia-offload-no-opt
      # desktop applications patched for GPU offloading
      (GPUOffloadApp inputs.zen-browser.packages."${pkgs.system}".default "zen-beta")
    ]
    ++ (with pkgs; [
      hmcl
      kazumi
      aseprite
      obs-studio
      teamspeak5_client

      chillcicada.et-astral

      # desktop applications patched for GPU offloading
      (GPUOffloadApp imv "imv")
      (GPUOffloadApp imv "imv-dir")
      (GPUOffloadApp mpv "mpv")
      (GPUOffloadApp mpv "umpv")
      (GPUOffloadApp kitty "kitty")
      (GPUOffloadApp kitty "kitty-open")
      (GPUOffloadApp typora "typora")
      (GPUOffloadApp zotero "zotero")
      (GPUOffloadApp kazumi "io.github.Predidit.Kazumi")
      (GPUOffloadApp obs-studio "com.obsproject.Studio")
      (GPUOffloadAppNoOpt hmcl "HMCL")
    ]);
}
