{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.tools;
in

{
  options.tools = {
    enable = lib.mkEnableOption "tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      dust # disk usage analyzer
      sops # secrets management
      tree # tree view
      tokei # count code lines
      typst # typesetting system
      killall # kill all processes by name
      nix-tree # nix tree view
    ];
  };
}
