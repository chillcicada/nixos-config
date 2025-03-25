_:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "Maple Mono SC NF";
      size = 13;
    };

    settings = {
      background_opacity = "0.9";
      dynamic_background_opacity = true;
      background_blur = 2;
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
  };
}
