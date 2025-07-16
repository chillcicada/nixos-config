{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    graphics.enable = lib.mkEnableOption "graphics";
  };

  config = lib.mkIf config.graphics.enable {
    # font config
    home.packages = with pkgs; [
      # Maple Mono (Ligature TTF unhinted)
      maple-mono.truetype
      # Maple Mono NF (Ligature unhinted)
      maple-mono.NF-unhinted
      # Maple Mono NF CN (Ligature unhinted)
      maple-mono.NF-CN-unhinted

      # noto fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];

    # image
    programs.imv = {
      enable = true;
      settings = { };
    };

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
    programs.zen-browser = {
      enable = true;
    };

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
        "ctrl+c" = "copy_or_interrupt";
      };

      shellIntegration = {
        enableZshIntegration = true;
      };
    };

    home.sessionVariables = {
      TERM = "kitty";
      TERMINAL = "kitty";
    };
  };
}
