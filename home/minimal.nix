{ pkgs, vars, ... }:

{
  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
    packages = with pkgs; [
      dust
      ufetch
      nix-tree
    ];
  };

  programs.eza = {
    enable = true;
    package = pkgs.eza;
    icons = "auto";
  };

  programs.helix = {
    enable = true;
    package = pkgs.helix;
    defaultEditor = true;
  };

  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    shellAliases = {
      # ! single character aliases
      f = "ufetch";
    };
  };

  # pick up which to use
  imports = [
    ./apps/btop.nix
    ./apps/nh.nix
    ./apps/starship.nix
    ./apps/zoxide.nix
  ];

  # disable fontconfig
  fonts.fontconfig.enable = false;

  programs.home-manager.enable = true;
}
