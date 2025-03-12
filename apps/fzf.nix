{ pkgs, config, vars, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
