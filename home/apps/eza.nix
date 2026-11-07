{ pkgs, ... }:

{
  packages = [ pkgs.eza ];

  rum.programs.zsh.initConfig = ''
    alias eza='eza --icons auto --git'
    alias ls='eza'
    alias ll='eza -l'
    alias la='eza -a'
    alias lt='eza --tree'
    alias lla='eza -la'
  '';
}
