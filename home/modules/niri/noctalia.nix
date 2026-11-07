{
  lib,
  pkgs,
  osConfig,
  ...
}:

let
  cfg = osConfig.desktop;

  polarity = osConfig.stylix.polarity;
  colors = osConfig.lib.stylix.colors.withHashtag;

  # Same token mapping as stylix' Noctalia target.
  palette = with colors; {
    mPrimary = base0D;
    mOnPrimary = base00;
    mSecondary = base0E;
    mOnSecondary = base00;
    mTertiary = base0C;
    mOnTertiary = base00;
    mError = base08;
    mOnError = base00;
    mSurface = base00;
    mOnSurface = base05;
    mHover = base0C;
    mOnHover = base00;
    mSurfaceVariant = base01;
    mOnSurfaceVariant = base04;
    mOutline = base03;
    mShadow = base00;

    terminal = {
      foreground = base05;
      background = base00;
      cursor = base05;
      cursorText = base00;
      selectionFg = base05;
      selectionBg = base02;

      normal = {
        black = base00;
        red = base08;
        green = base0B;
        yellow = base0A;
        blue = base0D;
        magenta = base0E;
        cyan = base0C;
        white = base05;
      };

      bright = {
        black = base03;
        red = base08;
        green = base0B;
        yellow = base0A;
        blue = base0D;
        magenta = base0E;
        cyan = base0C;
        white = base07;
      };
    };
  };

  toml = pkgs.formats.toml { };
  json = pkgs.formats.json { };

  settings = {
    shell = {
      font_family = osConfig.stylix.fonts.sansSerif.name;
      polkit_agent = true;
      panel.transparency_mode = "glass";
    };

    theme = {
      mode = polarity;
      source = "custom";
      custom_palette = "stylix";
    };

    wallpaper.default.path = toString osConfig.stylix.image;

    bar.main = {
      # Translucent so the compositor blur behind the bar is visible.
      background_opacity = 0.8;
      compositor_blur = true;

      # Roomier bar for the 1440p/1080p screens: taller, more padding and
      # spacing, and larger icons/text than the 34px/14px defaults.
      thickness = 44;
      padding = 20;
      widget_spacing = 10;
      scale = 1.15;
      font_scale = 1.15;
    };

    dock = {
      background_opacity = 0.85;
      compositor_blur = true;
    };

    notification.background_opacity = 0.9;
    osd.background_opacity = 0.9;
  };
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "niri") {
    xdg.config.files = {
      "noctalia/config.toml".source = toml.generate "noctalia-config.toml" settings;

      "noctalia/palettes/stylix.json".source = json.generate "stylix-palette.json" {
        ${polarity} = palette;
      };
    };
  };
}
