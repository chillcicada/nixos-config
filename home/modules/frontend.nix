{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.frontend;
in

{
  options.frontend = {
    enable = lib.mkEnableOption "frontend";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pnpm
      nodejs
    ];
  };
}
