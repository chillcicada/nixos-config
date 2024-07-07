{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnupg
    gnumake

    just
  ];

  programs = {
    # A modern replacement for 'cat'
    bat = {
      enable = true;
    };

    # A modern replacement for 'ls'
    eza = {
      enable = true;
      git = true;
      icons = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
      # https://github.com/catppuccin/fzf
      # catppuccin-mocha
      colors = {
        "bg+" = "#313244";
        "bg" = "#1e1e2e";
        "spinner" = "#f5e0dc";
        "hl" = "#f38ba8";
        "fg" = "#cdd6f4";
        "header" = "#f38ba8";
        "info" = "#cba6f7";
        "pointer" = "#f5e0dc";
        "marker" = "#f5e0dc";
        "fg+" = "#cdd6f4";
        "prompt" = "#cba6f7";
        "hl+" = "#f38ba8";
      };
    };

    z-lua = {
      enable = true;
      # TODO: add custom config
    };
  };
}
