{
  pkgs,
  config,
  vars,
  ...
}:

{
  # https://nixos.wiki/wiki/Visual_Studio_Code
  programs.vscode = {
    enable = true;
  };

  home.sessionVariables = {
    EDITOR = "code";
  };
}
