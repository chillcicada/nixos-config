{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.cpp;
in

{
  options.cpp = {
    enable = lib.mkEnableOption "cpp";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      xmake
    ];
  };
}
