{ inputs, pkgs, ... }:

let
  backgroundImage = "${inputs.imgs.packages."${pkgs.system}".default}/share/wallpapers/BA.png";
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    image = backgroundImage;
    enableReleaseChecks = false;
    polarity = "dark";

    targets = {
      gtk.enable = true;

      neovim.enable = false;
      vscode.enable = false;
    };

    # keep in sync with modules/core/font.nix
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
