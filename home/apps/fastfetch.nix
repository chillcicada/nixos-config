{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      modules = [
        # Header
        "title"
        "separator"

        # System Info
        "os"
        "host"
        "kernel"
        "packages"

        # Desktop Environment
        "de"
        "wm"

        # Shell/Terminal
        "shell"
        "terminal"

        # Hardware
        "display"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
      ];
    };
  };
}
