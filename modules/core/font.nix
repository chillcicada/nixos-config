{
  pkgs,
  ...
}:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira
      roboto
      lxgw-wenkai

      maple-mono
      maple-mono-NF
      maple-mono-SC-NF

      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      # Microsoft fonts
      nur.repos.rewine.ttf-ms-win10
      nur.repos.rewine.ttf-wps-fonts
      nur.repos.chillcicada.ttf-ms-win10-sc-sup

      # math fonts
      fira-math
      julia-mono
      newcomputermodern
      texlivePackages.cm
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        monospace = [
          "Maple Mono NF"
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

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        fcitx5-gtk # gtk support

        fcitx5-nord # theme

        fcitx5-mozc # japanese
        fcitx5-chinese-addons # chinese

        fcitx5-pinyin-zhwiki # pinyin lib
        fcitx5-pinyin-moegirl # pinyin lib
      ];

      ignoreUserConfig = false;

      settings = {
        addons = {
          classicui.globalSection.Theme = "Nord-Dark";
          classicui.globalSection.DarkTheme = "Nord-Dark";
        };

        inputMethod = {
          "Group/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Group/0/Items/0".Name = "keyboard-us";
          "Group/0/Items/1".Name = "shuangpin";
          "Group/0/Items/2".Name = "mozc";
          GroupOrder."0" = "Default";
        };
      };
    };
  };
}
