{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  patchDesktop =
    pkg: app: from: to:
    lib.hiPrio (
      pkgs.runCommand "patched-desktop-entry-for-${app}" { } ''
        mkdir -p $out/share/applications
        sed 's#${from}#${to}#g' < ${pkg}/share/applications/${app}.desktop > $out/share/applications/${app}.desktop
      ''
    );

  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";
in

{
  # ------------------ #
  # host configuration #
  # ------------------ #

  # Zsh extended configuration
  rum.programs.zsh.initConfig = ''
    # gnupg agent
    export GPG_TTY=$(tty)
    # gnupg agent end

    alias j='just'
    alias onproxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890 HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 ALL_PROXY=socks5://127.0.0.1:7890 no_proxy='
    alias offproxy='unset https_proxy http_proxy all_proxy HTTPS_PROXY HTTP_PROXY ALL_PROXY'
  '';

  # Keep Zen on the existing profile instead of creating a fresh one.
  # The profile itself stays in ~/.config/zen/594ztnss.default.
  xdg.config.files."zen/profiles.ini".text = ''
    [General]
    StartWithLastProfile=1
    Version=2

    [Profile0]
    Name=default
    IsRelative=1
    Path=594ztnss.default
    Default=1
  '';

  # -------------------- #
  # self defined options #
  # -------------------- #
  tools.enable = true;
  office.enable = true;
  desktop.enable = true;

  # develop.cpp.enable = true;
  develop.nix.enable = true;
  develop.misc.enable = true;
  # develop.rust.enable = true;
  develop.python.enable = true;
  # develop.frontend.enable = true;

  # editors.zed.enable = true;
  editors.neovim.enable = true;
  editors.vscode.enable = true;

  # ------------------- #
  # additional packages #
  # ------------------- #
  packages = [
    # desktop applications patched for GPU offloading
    (GPUOffloadApp inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default "zen-beta")
  ]
  ++ (with pkgs; [
    qq
    tg

    (GPUOffloadApp mpv "mpv")
    # (GPUOffloadApp zotero "zotero")
  ]);
}
