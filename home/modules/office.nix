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
      nur.repos.chillcicada.wpsoffice-cn
    ];

    # required by typora
    programs.pandoc = {
      enable = true;
    };

    home.file.".config/Typora/themes".source = inputs.typora-themes;
  };
}
