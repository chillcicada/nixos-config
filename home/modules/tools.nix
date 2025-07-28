{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    tools.enable = lib.mkEnableOption "tools";
  };

  config = lib.mkIf config.tools.enable {
    home.packages = with pkgs; [
      dust # disk usage analyzer
      sops # secrets management
      tree # tree view
      tokei # count code lines
      typst # typesetting system
      killall # kill all processes by name
      treefmt # tree format
      nix-tree # nix tree view
      patchelf # package utility
    ];
  };
}
