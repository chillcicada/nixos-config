{ ... }:

{
  # Zsh extended configuration from common.nix
  programs.zsh = {
    history.size = 20000;
    oh-my-zsh.plugins = [
      "git"
      "dotenv"
    ];
    initContent = ''
      # pnpm
      export PNPM_HOME="$HOME/.local/share/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end

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
      onproxy = "export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897 HTTP_PROXY=http://127.0.0.1:7897 HTTPS_PROXY=http://127.0.0.1:7897 ALL_PROXY=socks5://127.0.0.1:7897";
      offproxy = "unset https_proxy http_proxy all_proxy HTTPS_PROXY HTTP_PROXY ALL_PROXY";
    };
  };
}
