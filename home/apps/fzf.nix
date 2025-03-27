{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableZshIntegration = true;
  };
}
