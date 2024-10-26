{ pkgs
, config
, vars
, ...
}:

{
  stylix = {
    enable = true;
    image = ../_img/bg.jpg;

    polarity = "dark";
    autoEnable = true;
    # opacity.terminal = 0.1;

    targets = {
      gtk.enable = true;
      kitty.enable = false;
      fzf.enable = false;
      helix.enable = false;
      yazi.enable = false;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };
}
