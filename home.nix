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
    xz # xz
    zip # zip
    unzip # unzip
    ouch # unzip
    lz4 # lz4
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
    amberol # music player

    # lang
    zig

    bun
    nodejs
    pnpm
    yarn
    fnm
    quickjs-ng

    python311
    rye
    uv
    ruff
    conda

    nixpkgs-fmt

    typst
    typstyle
    tinymist

    rustup

    gfortran
    gnumake
    cmake
    xmake
    clang-tools
    llvm_19
    qt6.full
    qtcreator
    meson
    lldb_19

    go
    gopls

    selene

    # R&D
    zotero

    # programming
    vscode-fhs

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
    qbittorrent
    showmethekey

    nur.repos.chillcicada.degit-rs
    nur.repos.novel2430.wemeet-bin-bwrap
  ];

  imports = [
    ./apps
  ];

  home.sessionVariables = {
    GOPATH = "/etc/profiles/per-user/cc/bin/go";
    BROWSER = "firefox";
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
