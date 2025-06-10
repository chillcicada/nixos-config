{ lib, config, ... }:

{
  options = {
    clash.enable = lib.mkEnableOption "clash";
  };

  config = lib.mkIf config.clash.enable {
    programs.clash-verge = {
      enable = true;
      autoStart = true;
    };
  };
}
