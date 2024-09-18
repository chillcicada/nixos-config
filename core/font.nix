{ pkgs
, config
, ...
}:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      meslo-lg
      nerdfonts
      lxgw-wenkai
      noto-fonts
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "LXGW WenKai"
        ];
        sansSerif = [
          "LXGW WenKai"
          "Noto Sans"
        ];
        monospace = [
          "MesloLG LG L DZ"
          "LXGW WenKai Mono"
        ];
      };
    };
  };

  # Rime and Fcitx5 / iBus
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5"; # kde
    # ensure you have download iput method panel extension if you are using gnome
    # https://github.com/wengxt/gnome-shell-extension-kimpanel
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons # chinese
      fcitx5-gtk # gtk
      fcitx5-nord # theme
    ];
    # ! Abandon reason: ibus-rime is outdated
    # type = "ibus"; # gnome
    # ibus.engines = with pkgs.ibus-engines; [
    #   rime
    # ];
  };
}
