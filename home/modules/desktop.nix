{
  lib,
  config,
  pkgs,
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
    # image
    programs.imv.enable = true;

    # video & audio
    # https://wiki.nixos.org/wiki/MPV
    programs.mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
          ];

          mpv = pkgs.mpv-unwrapped.override { waylandSupport = true; };
        }
      );

      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
      };
    };

    # browser
    programs.zen-browser.enable = true;

    # terminal
    programs.kitty = {
      enable = true;

      settings = {
        dynamic_background_opacity = true;
        background_blur = 16;
        window_padding_width = 10;
        tab_bar_edge = "top";
      };

      keybindings = {
        # use the windows compatible keybindings
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
      };

      shellIntegration.enableZshIntegration = true;
    };

    programs.ghostty = {
      enable = true;

      enableZshIntegration = true;

      settings = {
        # Window
        window-vsync = true;
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
        # Others
        shell-integration-features = "cursor,sudo,title";
      };
    };
  };
}
