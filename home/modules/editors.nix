{
  inputs,
  lib,
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
    vscode-server.enable = lib.mkEnableOption "vscode-server";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.neovim.enable {
      stylix.targets.neovim.enable = false;

      programs.neovim = {
        enable = true;
        viAlias = true;
        withRuby = false;
        withPython3 = false;
      };

      home.packages = with pkgs; [
        unzip # Required by mason to download LSP servers
        gnumake # Required by luasnip.nvim
      ];

      home.file.".config/nvim".source = inputs.nvim-config;
    })

    (lib.mkIf cfg.vscode.enable {
      stylix.targets.vscode.enable = false;

      # https://nixos.wiki/wiki/Visual_Studio_Code
      programs.vscode = {
        enable = true;

        mutableExtensionsDir = true;
      };

      home.sessionVariables = {
        EDITOR = "code";
      };

      # VSCode Extension Typst Math
      home.packages = with pkgs; [ chillcicada.font-typst-math ];
    })

    (lib.mkIf cfg.vscode-server.enable {
      services.vscode-server.enable = true;
    })

    (lib.mkIf cfg.zed.enable {
      programs.zed-editor = {
        enable = true;
      };
    })
  ];
}
