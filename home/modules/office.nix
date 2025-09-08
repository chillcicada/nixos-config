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
      typora
      wechat
      zotero

      chillcicada.wpsoffice-cn

      # Fonts
      lxgw-wenkai

      # Microsoft fonts & WPS fonts
      chillcicada.ttf-ms-win10-wps-mix
      chillcicada.ttf-ms-win10-sc-sup
    ];

    # Required by typora
    programs.pandoc.enable = true;

    home.file.".config/Typora/themes".source = inputs.typora-themes;
  };
}
