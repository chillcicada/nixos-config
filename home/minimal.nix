{ pkgs, vars, ... }:

{
  home = {
    username = vars.userName;
    homeDirectory = "/home/${vars.userName}";
    packages = with pkgs; [
      curl
      dust
      wget
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

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        show_symlink = true;
      };
      preview = {
        wrap = "yes";
        tab_size = 2;
      };
      opener = {
        edit = [
          {
            run = "hx $@";
            block = true;
          }
        ];
      };
    };
  };

  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    initExtra = ''
      # yazi
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
      # yazi end
    '';
    shellAliases = {
      # ! special character alias
      f = "fastfetch";
    };
  };

  imports = [
    ./apps/bat.nix
    ./apps/btop.nix
    ./apps/fastfetch.nix
    ./apps/fzf.nix
    ./apps/nh.nix
    ./apps/ripgrep.nix
    ./apps/starship.nix
    ./apps/zoxide.nix
  ];

  # misc
  fonts.fontconfig.enable = false;

  programs.home-manager.enable = true;
}
