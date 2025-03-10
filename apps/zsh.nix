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

      # rye
      export PATH="$HOME/.rye/shims/:$PATH"
      # rye end
    '';
    shellAliases = {
      # ! special character alias
      f = "fastfetch";
      j = "just";
      y = "yazi";
      o = "onefetch";
      c = "code";

      proxyon = "export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897";
      proxyoff = "unset https_proxy http_proxy all_proxy";
    };
  };
}
