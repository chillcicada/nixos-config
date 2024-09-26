{ pkgs
, config
, ...
}:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";

    font = {
      name = "MesloLGL Nerd Font Mono";
      size = 13;
    };

    settings = {
      background_opacity = "0.9";
      tab_bar_edge = "top";
    };
  };
}
