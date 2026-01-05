{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.vscode;
in

{
  options.vscode = {
    enable = lib.mkEnableOption "vscode";

    server.enable = lib.mkEnableOption "vscode server";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
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

    (lib.mkIf cfg.server.enable {
      services.vscode-server.enable = true;
    })
  ];
}
