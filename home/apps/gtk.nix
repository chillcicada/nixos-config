{ ... }:

{
  gtk = {
    enable = true;

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
