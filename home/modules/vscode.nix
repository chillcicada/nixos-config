{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    vscode.enable = lib.mkEnableOption "vscode";
  };

  config = lib.mkIf config.vscode.enable {
    stylix.targets.vscode.enable = false;

    # https://nixos.wiki/wiki/Visual_Studio_Code
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = true;
    };

    services.vscode-server.enable = true;

    home.sessionVariables = {
      EDITOR = "code";
    };

    # Typst Math
    home.packages = with pkgs; [ chillcicada.font-typst-math ];
  };
}
