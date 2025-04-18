{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      fira
      roboto
      lxgw-wenkai

      maple-mono.truetype
      maple-mono.NF-unhinted
      maple-mono.NF-CN-unhinted

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
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [
          "Noto Serif CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        monospace = [
          "Maple Mono NF CN"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
