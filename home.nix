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
    xz
    zip
    unzip
    lz4
    nnn
    jq
    cloc
    tokei
    difftastic
    btop
    delta
    fastfetch
    onefetch
    nh

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

    # misc
    yesplaymusic
    typos
    nom
    firefox-beta
    fh
    ffmpeg-full
    pandoc
    typora
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
