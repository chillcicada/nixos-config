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

  # add __GL_THREADED_OPTIMIZATIONS=0 to disable threaded optimizations for nvidia-offload
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
  coreutils.enable = true;
  tools.enable = true;

  cpp.enable = true;
  frontend.enable = true;
  nixlang.enable = true;
  python.enable = true;
  typst.enable = true;
  # endregion

  # region gui
  graphics.enable = true;
  fcitx5.enable = true;
  vscode.enable = true;
  neovim.enable = true;

  im.enable = true;
  office.enable = true;
  # endregion

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
