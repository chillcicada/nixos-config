{ pkgs
, config
, ...
}:

{
  home.username = "cc";
  home.homeDirectory = "/home/cc";

  home.packages = with pkgs; [
    # tools
    bat
    eza
    yazi
    xz
    zip
    unzip
    nnn
    jq
    cloc

    # lang
    zig

    bun
    nodejs
    pnpm
    yarn
    fnm

    python311
    rye
    uv
    ruff

    typst
    typstyle
    tinymist

    rustup

    gcc
    gnumake
    cmake
    xmake
    clang-tools

    go
    gopls

    selene

    # R&D
    zotero-beta
    libreoffice-qt6-fresh

    # terminal
    kitty

    # misc
    fastfetch
    yesplaymusic
    htop
    typos
    nom
    firefox-beta
  ];

  imports = [
    ./apps
  ];

  home.sessionVariables = {
    GOPATH = "/etc/profiles/per-user/cc/bin/go";
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
