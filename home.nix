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
    delta # better diff for git
    fastfetch # view system info
    onefetch # view git repo info
    nh # nixos helper
    dust # disk usage
    openssl # openssl
    navi # navigate cli commands
    tree # tree
    pkg-config # pkg-config
    parallel # parallel

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

    gfortran
    gnumake
    cmake
    xmake
    clang-tools
    llvm_18
    qt6.full
    qtcreator

    go
    gopls

    selene

    # R&D
    zotero
    libreoffice

    # programming
    lapce
    vscode-fhs
    zed-editor

    # qemu
    qemu
    quickemu

    # misc
    typos
    nom
    fh
    ffmpeg-full
    pandoc
    typora
    seafile-client
    wechat-uos
    qq
    quarto
    wpsoffice-cn
    obs-studio
    openutau
    amberol

    nur.repos.chillcicada.degit-rs
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
