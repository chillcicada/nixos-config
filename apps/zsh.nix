{ pkgs
, config
, vars
, ...
}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "dotenv"
      ];
    };
    initExtra = ''
      # pnpm
      export PNPM_HOME="/home/cc/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      # fnm
      eval "$(fnm env --use-on-cd --shell zsh)"
      # fnm end

      # cargo
      export PATH="$HOME/.cargo/bin:$PATH"
      # cargo end
    '';
    shellAliases = {
      gpl = "git pull"; # keep consistent with my windows config

      # ! special character alias
      # g = "git"; # provided by oh-my-zsh
      f = "fastfetch";
      j = "just";
      y = "yazi";
      o = "onefetch";
      c = "code";
    };
  };
}
