{ pkgs, ... }:

{
  # https://nixos.wiki/wiki/Visual_Studio_Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    mutableExtensionsDir = true;
  };

  stylix.targets.vscode.enable = false;

  home.sessionVariables = {
    EDITOR = "code";
  };
}
