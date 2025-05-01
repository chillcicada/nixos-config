{ ... }:

{
  programs.fastfetch = {
    enable = true;

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

        # Set a break
        "break"

        # Color Scheme
        "colors"
      ];
    };
  };
}
