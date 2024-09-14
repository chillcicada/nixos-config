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

  # Rime and Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-nord
    ];
  };
}
