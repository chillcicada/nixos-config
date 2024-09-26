{ pkgs
, config
, ...
}:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";

    font = {
      name = "MesloLGMDZ Nerd Font";
      size = 13;
    };

    settings = {
      background_opacity = "0.9";
      tab_bar_edge = "top";
      hide_window_decorations = true;
    };
  };
}
