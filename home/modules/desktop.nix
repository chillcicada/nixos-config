{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.desktop;
in

{
  options.desktop = {
    enable = lib.mkEnableOption "desktop";
  };

  config = lib.mkIf cfg.enable {
    # image viewer
    rum.programs.imv.enable = true;

    # video & audio player
    # https://wiki.nixos.org/wiki/MPV
    rum.programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        uosc
        bdanmaku # bilibili
        sponsorblock # youtube
      ];

      bindings = {
        esc = "quit";
      };

      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
      };
    };

    # browser
    packages = [ inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default ];

    # terminal emulator
    # run `infocmp -x xterm-ghostty | ssh <remote-host> -- tic -x -` to install the terminfo
    rum.programs.zsh.initConfig = ''
      if [[ -r "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration ]]; then
        source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
      fi
    '';

    rum.programs.ghostty = {
      enable = true;

      settings = {
        # Window
        window-vsync = false;
        window-height = 35;
        window-width = 135;
        window-padding-x = 10;
        gtk-titlebar-style = "tabs";
        window-inherit-font-size = true;
        # Keybind
        keybind = [
          "ctrl+v=paste_from_clipboard"
        ];
        # Preference
        bold-is-bright = true;
        cursor-style = "bar";
        cursor-opacity = 0.8;
        link-url = true;
        confirm-close-surface = false;
        background-blur = true;
        # Keep the text opaque; only the terminal background is translucent.
        background-opacity = 0.85;
        # Others
        shell-integration-features = "cursor,sudo,title";
      };
    };
  };
}
