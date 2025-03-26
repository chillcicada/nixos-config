_:

{
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
}
