{ inputs, pkgs }:

[ inputs.zen-browser.packages."${pkgs.system}".default ]
++ (
  with pkgs;
  [
    # core & utils
    fh # flake generator
    curl # cli http client
    dust # disk usage
    tree # tree view
    wget # download files
    tokei # count code lines
    typos # typo correction
    unzip # unzip files, required by nvim
    cachix # nix binary cache
    treefmt # tree format
    difftastic # diff tool

    # js/ts
    pnpm
    nodejs

    # python
    uv
    rye
    ruff
    python311

    # typst
    typst
    typstyle # formatter

    # rust
    rustup

    # c/c++
    gcc
    xmake
    clang-tools # provides clangd and clang-format

    # nix
    nil # nix linter
    nixfmt-rfc-style # formatter

    # lua
    selene # lua linter
    stylua # lua formatter
    tree-sitter # required by nvim
    lua51Packages.lua
    luajitPackages.luarocks

    # misc
    qq
    typora
    zotero
    wechat-uos
    wakatime-cli
    teamspeak5_client
  ]
  ++ (with nur.repos; [
    # nur
    chillcicada.typship
    chillcicada.degit-rs
    chillcicada.wpsoffice-cn
    novel2430.wemeet-bin-bwrap-wayland-screenshare
  ])
)
