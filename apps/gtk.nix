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

    gtk2.extraConfig = ''
      gtk-im-module = "fcitx"
    '';

    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };

    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };
}
