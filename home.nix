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
    openssh
    xz
    yazi
    zip
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
    zotero
    libreoffice-qt6-fresh

    # misc
    fastfetch
    yesplaymusic
    htop
    typos
  ];

  imports = [
    ./apps
  ];

  home.sessionVariables = {
    GOPATH = "/etc/profiles/per-user/cc/bin/go";
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
