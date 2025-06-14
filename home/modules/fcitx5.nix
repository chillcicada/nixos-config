{ lib, config, ... }:

{
  options = {
    fcitx5.enable = lib.mkEnableOption "fcitx5";
  };

  config = lib.mkIf config.fcitx5.enable {
    gtk = {
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
  };
}
