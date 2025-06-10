{ pkgs, vars, ... }:

{
  # pick up which to use
  imports = [
    ./apps/nh.nix
    ./apps/btop.nix
    ./apps/helix.nix
    ./apps/zoxide.nix
  ];

  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
    packages = with pkgs; [
      dust
      ufetch # alternative to fastfetch
      nix-tree
    ];
  };

  programs.eza = {
    enable = true;
    icons = "auto";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      username.disabled = true;
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[×](bold red)";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    shellAliases = {
      # ! single character aliases
      f = "ufetch";
    };
  };

  # set helix as the default editor
  programs.helix.defaultEditor = true;

  programs.home-manager.enable = true;
}
