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

  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in

{
  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

  # self defined options
  coreutils.enable = true;
  tools.enable = true;
  graphics.enable = true;
  fcitx5.enable = true;

  cpp.enable = true;
  frontend.enable = true;
  nixlang.enable = true;
  python.enable = true;
  typst.enable = true;

  vscode.enable = true;
  neovim.enable = true;

  im.enable = true;
  office.enable = true;

  home.packages =
    [
      # desktop applications patched for GPU offloading
      (GPUOffloadApp inputs.zen-browser.packages."${pkgs.system}".default "zen-beta")
    ]
    ++ (with pkgs; [
      hmcl
      kazumi
      aseprite
      obs-studio
      teamspeak5_client
      nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare

      # desktop applications patched for GPU offloading
      (GPUOffloadApp hmcl "HMCL")
      (GPUOffloadApp kazumi "io.github.Predidit.Kazumi")
      (GPUOffloadApp obs-studio "com.obsproject.Studio")
    ]);
}
