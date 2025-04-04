{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;
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
    '';
    shellAliases = {
      # ! special character alias
      f = "fastfetch";
      j = "just";
      y = "yazi";
      c = "code";
      py = "python";

      proxyon = "export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897";
      proxyoff = "unset https_proxy http_proxy all_proxy";
    };
  };
}
