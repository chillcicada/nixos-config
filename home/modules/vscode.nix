{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    vscode.enable = lib.mkEnableOption "vscode";

    vscode.server.enable = lib.mkEnableOption "vscode server";
  };

  config = lib.mkMerge [
    (lib.mkIf config.vscode.enable {
      stylix.targets.vscode.enable = false;

      # https://nixos.wiki/wiki/Visual_Studio_Code
      programs.vscode = {
        enable = true;

        mutableExtensionsDir = true;
      };

      home.sessionVariables = {
        EDITOR = "code";
      };

      # Typst Math
      home.packages = with pkgs; [ chillcicada.font-typst-math ];
    })

    (lib.mkIf config.vscode.server.enable {
      services.vscode-server.enable = true;
    })
  ];
}
