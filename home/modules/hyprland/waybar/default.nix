{ ... }:

{
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/config.jsonc".source = ./config.jsonc;
}
