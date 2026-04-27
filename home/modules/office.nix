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
      wpsoffice-cn

      chillcicada.font-office
    ];

    home.file.".config/Typora/themes".source = inputs.typora-themes;
  };
}
