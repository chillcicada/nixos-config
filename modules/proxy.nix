{
  vars,
  config,
  lib,
  ...
}:

let
  cfg = config.proxy;
in

{
  options.proxy = {
    enable = lib.mkEnableOption "proxy";
  };

  config = lib.mkIf cfg.enable {
    services.dae = {
      enable = true;
      configFile = "/home/${vars.userName}/.config/config.dae";
      openFirewall.enable = true;
      openFirewall.port = 22222;
    };
  };
}
