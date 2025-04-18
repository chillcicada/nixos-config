{ pkgs, ... }:

{
  services.mihomo = {
    enable = true;
    webui = pkgs.metacubexd;
    configFile = ./config.yaml;
  };
}
