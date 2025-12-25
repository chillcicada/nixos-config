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
      wpsoffice-cn

      # Microsoft fonts
      chillcicada.ttf-ms-win10
      chillcicada.ttf-ms-win10-sc-sup
    ];

    home.file.".config/Typora/themes".source = inputs.typora-themes;
  };
}
