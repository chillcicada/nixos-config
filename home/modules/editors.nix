{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:

let
  cfg = config.editors;
in

{
  options.editors = {
    zed.enable = lib.mkEnableOption "zed";
    neovim.enable = lib.mkEnableOption "neovim";
    vscode.enable = lib.mkEnableOption "vscode";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.neovim.enable {
      packages = with pkgs; [
        neovim
        gcc # Required by tree-sitter
        unzip # Required by mason to download LSP servers
        gnumake # Required by luasnip.nvim
      ];

      files.".config/nvim".source = inputs.nvim-config;

      rum.programs.zsh.initConfig = ''
        alias vi='nvim'
      '';
    })

    (lib.mkIf cfg.vscode.enable {
      # https://nixos.wiki/wiki/Visual_Studio_Code
      rum.programs.vscode.enable = true;

      # VSCode Extension Typst Math
      packages = with pkgs; [ chillcicada.font-typst-math ];

      environment.sessionVariables = {
        EDITOR = "code";
        WAKATIME_HOME = config.xdg.config.directory;
      };
    })

    (lib.mkIf cfg.zed.enable {
      rum.programs.zed.enable = true;
    })
  ];
}
