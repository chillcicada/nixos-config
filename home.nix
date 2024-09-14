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
    fastfetch
    yazi
    zip
    nnn
    jq

    # lang
    zig

    bun
    nodejs
    pnpm
    yarn

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

    # R&D
    zotero
    libreoffice-qt6-fresh

    # misc
    fastfetch
    yesplaymusic
  ];

  imports = [
    ./apps
  ];

  home.sessionVariables = {
    GOPATH = "/home/cc/.local/share/go";
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
