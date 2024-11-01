{ pkgs
, config
, vars
, ...
}:

{
  home.username = "cc";
  home.homeDirectory = "/home/cc";

  home.packages = with pkgs; [
    # tools
    bat # cat
    xz # xz
    zip # zip
    unzip # unzip
    ouch # unzip
    lz4 # lz4
    nnn # file manager
    jq # json parser
    cloc # count lines of code
    tokei # count lines of code
    difftastic # diff tool
    btop # better top, htop
    delta # better diff for git
    fastfetch # view system info
    onefetch # view git repo info
    nh
    dust # disk usage
    openssl # openssl
    navi # navigate cli commands
    tree # tree
    pkg-config # pkg-config

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
    llvm_18

    go
    gopls

    selene

    # R&D
    zotero
    libreoffice
    trilium-desktop

    # programming
    lapce
    vscode-fhs
    zed-editor

    # qemu
    qemu
    quickemu

    # misc
    yesplaymusic
    typos
    nom
    firefox
    fh
    ffmpeg-full
    pandoc
    typora

    wechat-uos
    qq
    discord
    wpsoffice
    obs-studio
    telegram-desktop
  ];

  imports = [
    ./apps
    ./pkgs
  ];

  home.sessionVariables = {
    GOPATH = "/etc/profiles/per-user/cc/bin/go";
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
