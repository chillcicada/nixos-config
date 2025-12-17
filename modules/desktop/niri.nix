{
  lib,
  config,
  ...
}:

let
  cfg = config.desktop;
in

{
  config = lib.mkIf (cfg.enable && cfg.wm == "niri") {
    programs.niri = {
      enable = true;
    };
  };
}
