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

  programs.fd = {
    enable = true;
    package = pkgs.fd;
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
  };

  # pick up which to use
  imports = [
    ./apps/bat.nix
    ./apps/btop.nix
    ./apps/fzf.nix
    ./apps/nh.nix
    ./apps/ripgrep.nix
    ./apps/starship.nix
    ./apps/zoxide.nix
  ];

  # disable fontconfig
  fonts.fontconfig.enable = false;

  programs.home-manager.enable = true;
}
