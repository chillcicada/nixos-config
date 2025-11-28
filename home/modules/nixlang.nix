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
      gh # required by nixpkgs-review

      nil # linter
      nixfmt # formatter

      nixpkgs-review # nixpkgs review tool
    ];
  };
}
