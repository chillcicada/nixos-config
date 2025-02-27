{ pkgs
, config
, vars
, lib
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
    postman

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
    meson
    lldb_19

    go
    gopls

    selene

    # R&D
    zotero

    # programming
    vscode-fhs
    ghostty

    # misc
    typos
    nom
    fh
    pandoc
    typora
    wechat-uos
    qq
    quarto
    qbittorrent
    wpsoffice-cn

    itch
    teamspeak5_client

    nur.repos.chillcicada.degit-rs
    # nur.repos.chillcicada.tunet-rust
    nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
    nur.repos.xddxdd.baidunetdisk
  ];

  imports = [
    ./apps
  ];

  home.sessionVariables = {
    GOPATH = "/etc/profiles/per-user/cc/bin/go";
    BROWSER = "firefox";
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  # linked to https://github.com/catppuccin/nix/issues/275
  qt = lib.mkForce {
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
