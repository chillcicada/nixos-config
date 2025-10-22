{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  cfg = config.office;
in

{
  options.office = {
    enable = lib.mkEnableOption "office";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Office software
      typora
      wechat
      zotero
      chillcicada.wpsoffice-cn

      # Fonts
      lxgw-wenkai

      # Microsoft fonts & WPS fonts
      chillcicada.ttf-wps-fonts
      chillcicada.ttf-ms-win10-sc-sup
    ];

    home.file.".config/Typora/themes".source = inputs.typora-themes;
  };
}
