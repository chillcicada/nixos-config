{ lib, config, ... }:

let
  cfg = config.essential;
in

{
  config = lib.mkIf (cfg.enable && cfg.proxy.enable) {
    programs.clash-verge = {
      enable = true;
      # autoStart = true;
    };
  };
}
