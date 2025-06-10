{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    cpp.enable = lib.mkEnableOption "cpp";
  };

  config = lib.mkIf config.cpp.enable {
    home.packages = with pkgs; [
      gcc
      xmake
    ];
  };
}
