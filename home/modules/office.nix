{
  lib,
  config,
  pkgs,
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
    packages = with pkgs; [
      wechat
      # zotero
      wpsoffice-cn

      chillcicada.font-office
    ];
  };
}
