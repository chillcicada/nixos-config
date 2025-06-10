{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    typst.enable = lib.mkEnableOption "typst";
  };

  config = lib.mkIf config.typst.enable {
    home.packages = with pkgs; [
      typst
    ];
  };
}
