{ pkgs, ... }:

{
  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

  home.packages =
    with pkgs;
    [ ]
    ++ (with nur.repos; [
      novel2430.wemeet-bin-bwrap-wayland-screenshare
    ]);

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
