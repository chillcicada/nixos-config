{ config
, pkgs
, ...
}:

{
  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };
}
