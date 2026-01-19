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
      pkgs.runCommand "$patched-desktop-entry-for-${app}" { } ''
        mkdir -p $out/share/applications
        sed 's#${from}#${to}#g' < ${pkg}/share/applications/${app}.desktop > $out/share/applications/${app}.desktop
      ''
    );

  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";

  # # add __GL_THREADED_OPTIMIZATIONS=0 to disable threaded optimizations for nvidia-offload, used by minecraft
  # nvidia-offload-no-opt = pkgs.writeShellScriptBin "nvidia-offload-no-opt" ''
  #   __GL_THREADED_OPTIMIZATIONS=0 nvidia-offload "$@"
  # '';

  # GPUOffloadAppNoOpt =
  #   pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload-no-opt ";
in

{
  # ------------------ #
  # host configuration #
  # ------------------ #

  # Zsh extended configuration
  programs.zsh = {
    oh-my-zsh.plugins = [
      "git"
      "dotenv"
    ];

    initContent = ''
      # pnpm
      export PNPM_HOME="$HOME/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      # gnupg agent
      export GPG_TTY=$(tty)
      # gnupg agent end
    '';
  };

  # Extended GTK configuration
  gtk = {
    enable = true;

    gtk2.enable = false;

    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };

    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };

  # Top level shell aliases
  home.shellAliases = {
    j = "just";
    onproxy = "export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890 HTTP_PROXY=http://127.0.0.1:7890 HTTPS_PROXY=http://127.0.0.1:7890 ALL_PROXY=socks5://127.0.0.1:7890 no_proxy=";
    offproxy = "unset https_proxy http_proxy all_proxy HTTPS_PROXY HTTP_PROXY ALL_PROXY";
  };

  # Fix stylix targets
  stylix.targets = {
    kde.enable = false;
    gdu.enable = false;
    forge.enable = false;
    gedit.enable = false;
    blender.enable = false;
    vencord.enable = false;

    zen-browser.profileNames = [ "594ztnss.default" ];
  };

  # -------------------- #
  # self defined options #
  # -------------------- #
  tools.enable = true;
  office.enable = true;
  desktop.enable = true;

  develop.cpp.enable = true;
  develop.nix.enable = true;
  develop.rust.enable = true;
  develop.python.enable = true;
  develop.frontend.enable = true;

  editors.zed.enable = true;
  editors.neovim.enable = true;
  editors.vscode.enable = true;
  editors.vscode-server.enable = true;

  # ------------------- #
  # additional packages #
  # ------------------- #
  home.packages = [
    # nvidia-offload-no-opt
    # desktop applications patched for GPU offloading
    (GPUOffloadApp inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default "zen-beta")
  ]
  ++ (with pkgs; [
    qq
    # hmcl
    # (GPUOffloadAppNoOpt hmcl "HMCL")
    wemeet
    flclash
    # aseprite
    # obs-studio
    # (GPUOffloadApp obs-studio "com.obsproject.Studio")
    # teamspeak6-client
    # chillcicada.et-astral

    (GPUOffloadApp imv "imv")
    (GPUOffloadApp imv "imv-dir")
    (GPUOffloadApp mpv "mpv")
    (GPUOffloadApp mpv "umpv")
    (GPUOffloadApp typora "typora")
    (GPUOffloadApp zotero "zotero")
  ]);
}
