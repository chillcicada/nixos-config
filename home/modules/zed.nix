{ lib, config, ... }:

let
  cfg = config.zed;
in

{
  options.zed = {
    enable = lib.mkEnableOption "zed";
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
    };
  };
}
