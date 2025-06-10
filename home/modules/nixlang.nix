{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    nixlang.enable = lib.mkEnableOption "nixlang";
  };

  config = lib.mkIf config.nixlang.enable {
    home.packages = with pkgs; [
      nil # linter
      nixfmt-rfc-style # formatter
    ];
  };
}
