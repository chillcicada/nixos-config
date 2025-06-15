{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    cjk.enable = lib.mkEnableOption "cjk";
  };

  config = lib.mkIf config.cjk.enable {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        fira
        roboto
        lxgw-wenkai

        # nerd fonts
        maple-mono.truetype
        maple-mono.NF-unhinted
        maple-mono.NF-CN-unhinted

        # Noto fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        # Microsoft fonts & WPS fonts
        nur.repos.rewine.ttf-ms-win10
        nur.repos.rewine.ttf-wps-fonts
        nur.repos.chillcicada.ttf-ms-win10-sc-sup
      ];

      fontconfig = {
        enable = true;

        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          serif = [ "Noto Serif CJK SC" ];
          sansSerif = [ "Noto Sans CJK SC" ];
          monospace = [ "Maple Mono NF CN" ];
        };
      };
    };
  };
}
