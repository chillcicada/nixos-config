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

    fonts = {
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
