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
    initContent = ''
      # pnpm
      export PNPM_HOME="$HOME/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

      # cargo
      export PATH="$PATH:$HOME/.cargo/bin"
      # cargo end

      # uv
      export PATH="$PATH:$HOME/.local/bin"
      # uv end
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
