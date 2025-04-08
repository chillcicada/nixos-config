{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 20000;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "dotenv"
      ];
    };
    plugins = [ ];
    initExtra = ''
      # pnpm
      export PNPM_HOME="/home/cc/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      # cargo
      export PATH="$PATH:$HOME/.cargo/bin"
      # cargo end

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
      j = "just";
      c = "code";
      py = "python";

      # ! custom aliases
      onproxy = "export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897";
      offproxy = "unset https_proxy http_proxy all_proxy";
    };
  };
}
