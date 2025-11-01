{ pkgs, ... }:

let
  backgroundImage = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/chillcicada/imgs/refs/heads/main/wallpapers/BA.png";
    hash = "sha256-faTiAZN+Uaidve5McdD07idk6Q1ISxeiQXhtNHARM/s=";
  };
in

{
  home.packages = with pkgs; [
    # Maple Mono (Ligature TTF unhinted)
    maple-mono.truetype
    # Maple Mono NF (Ligature unhinted)
    maple-mono.NF-unhinted
    # Maple Mono NF CN (Ligature unhinted)
    maple-mono.NF-CN-unhinted
  ];

  stylix = {
    enable = true;
    enableReleaseChecks = false;
    autoEnable = true;

    image = backgroundImage;
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK SC";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK SC";
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

    cursor = {
      package = pkgs.catppuccin-cursors.mochaLavender;
      name = "catppuccin-mocha-lavender-cursors";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    opacity = {
      terminal = 0.8;
    };
  };
}
