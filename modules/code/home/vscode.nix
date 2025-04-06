{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Visual_Studio_Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  home.sessionVariables = {
    EDITOR = "code";
  };
}
