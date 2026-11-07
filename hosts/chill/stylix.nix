{ pkgs, lib, ... }:

let
  backgroundImage = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/chillcicada/imgs/refs/heads/main/wallpapers/BA.png";
    hash = "sha256-faTiAZN+Uaidve5McdD07idk6Q1ISxeiQXhtNHARM/s=";
  };

  iconTheme = pkgs.catppuccin-papirus-folders.override {
    flavor = "mocha";
    accent = "lavender";
  };

  cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
in

{
  # Stylix is applied at the system level: it has no hjem module, so
  # per-program targets (ghostty, btop, yazi, …) are no longer themed
  # automatically.
  stylix = {
    enable = true;
    enableReleaseChecks = false;

    image = backgroundImage;
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.lxgw-fonts.neozhisong-screen;
        name = "LXGW Neo ZhiSong Screen";
      };

      sansSerif = {
        package = pkgs.lxgw-fonts.neoxihei-screen;
        name = "LXGW Neo XiHei Screen";
      };

      monospace = {
        package = pkgs.maple-mono.NF-CN-unhinted;
        name = "Maple Mono NF CN";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 13;
      };
    };

    cursor = cursorTheme;

    icons = {
      enable = true;
      package = iconTheme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    # The GNOME target patches and rebuilds gnome-shell; skip it. The
    # previous user-level theming is replaced by the dconf defaults below.
    targets = {
      gnome.enable = false;
      qt.enable = false;
    };
  };

  fonts.packages = with pkgs; [
    # Extra Maple Mono variants used by applications.
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted

    # Office fonts, needed by WPS Office and friends. Fonts in the hjem
    # user's `packages` are not registered with fontconfig, so they must
    # be listed here.
    chillcicada.font-office
  ];

  environment = {
    systemPackages = [
      iconTheme
      cursorTheme.package
    ];

    sessionVariables.XCURSOR_THEME = cursorTheme.name;
  };

  # User-level defaults that Stylix's Home Manager module used to write.
  programs.dconf = {
    enable = true;

    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/background" = {
            picture-uri = "file://${backgroundImage}";
            picture-uri-dark = "file://${backgroundImage}";
            picture-options = "zoom";
            color-shading-type = "solid";
          };

          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            cursor-theme = cursorTheme.name;
            cursor-size = lib.gvariant.mkInt32 cursorTheme.size;
            icon-theme = "Papirus-Dark";
            font-name = "LXGW Neo XiHei Screen 12";
            document-font-name = "LXGW Neo ZhiSong Screen 11";
            monospace-font-name = "Maple Mono NF CN 12";
          };
        };
      }
    ];
  };
}
