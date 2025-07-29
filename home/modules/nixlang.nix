{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.nixlang;
in

{
  options.nixlang = {
    enable = lib.mkEnableOption "nixlang";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nil # linter
      nixfmt-rfc-style # formatter
    ];
  };
}
