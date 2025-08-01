{ vars, ... }:

{
  # https://nix-community.github.io/home-manager/options.xhtml
  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Enable Btop
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
    };
  };

  # Enable Eza
  programs.eza = {
    enable = true;
    icons = "auto";
  };

  # Enable Starship
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    # https://starship.rs/config/
    settings = {
      username.disabled = true;
      nix_shell.disabled = true;

      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[×](bold red)";
      };
    };
  };

  # Enable Zoxide
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Enable Zsh & oh-my-zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh.enable = true;
    history.ignoreAllDups = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
