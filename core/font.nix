{ pkgs
, config
, vars
, ...
}:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      meslo-lg
      nerd-fonts.meslo-lg
      nerd-fonts.roboto-mono
      nerd-fonts.noto
      lxgw-wenkai
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      eb-garamond
      fira
      fira-mono
      fira-code
      hack-font
      inter
      iosevka
      jetbrains-mono
      liberation_ttf
      roboto
      roboto-mono
      roboto-serif
      sarasa-gothic
      source-han-mono
      source-han-sans
      source-han-serif
      wqy_microhei
      wqy_zenhei
      nur.repos.rewine.ttf-wps-fonts
      nur.repos.rewine.ttf-ms-win10
      newcomputermodern # new computer modern font
      texlivePackages.cm # computer modern font
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
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons # chinese
      fcitx5-gtk # gtk
      fcitx5-nord # theme
    ];
  };

  environment.sessionVariables = rec {
    QT_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    QT_QPA_PLATFORM = "wayland";
  };
}
