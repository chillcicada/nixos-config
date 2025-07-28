{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    office.enable = lib.mkEnableOption "office";
  };

  config = lib.mkIf config.office.enable {
    home.packages = with pkgs; [
      typora
      zotero

      chillcicada.wemeet
      chillcicada.wpsoffice-cn

      # Fonts
      lxgw-wenkai

      # Microsoft fonts & WPS fonts
      chillcicada.ttf-ms-win10-wps-mix
      chillcicada.ttf-ms-win10-sc-sup
    ];

    # required by typora
    programs.pandoc.enable = true;

    home.file.".config/Typora/themes".source = inputs.typora-themes;
  };
}
