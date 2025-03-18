{
  pkgs,
  config,
  vars,
  ...
}:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      julia-mono

      maple-mono
      maple-mono-otf
      maple-mono-NF
      maple-mono-SC-NF
      maple-mono-autohint

      lxgw-wenkai

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji

      fira
      fira-mono
      fira-code

      roboto
      roboto-mono
      roboto-serif

      source-han-mono
      source-han-sans
      source-han-serif

      wqy_microhei
      wqy_zenhei

      nur.repos.rewine.ttf-wps-fonts
      nur.repos.rewine.ttf-ms-win10

      texlivePackages.cm
      texlivePackages.firamath-otf
      texlivePackages.newcomputermodern
    ];
    fontconfig = {
      defaultFonts = {
        serif = [
          "Source Han Serif"
        ];
        sansSerif = [
          "Source Han Sans"
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
        fcitx5-chinese-addons # chinese
        fcitx5-mozc # japanese
        fcitx5-gtk # gtk lib
        fcitx5-nord # theme

        fcitx5-pinyin-moegirl # pinyin
        fcitx5-pinyin-zhwiki # pinyin
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
